using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;

public class PlayerMove : MonoBehaviour
{
    private Rigidbody rb;

    [Header("輸入")]
    [SerializeField] private PlayerTeam team;
    [SerializeField] private string horizontalInputString;
    [SerializeField] private string jumpInputString;
    [SerializeField] private string smashInputString;
    [SerializeField] private string blockInputString;
    [SerializeField] private SpriteRenderer spriteRenderer;
    [SerializeField] private Animator animator;
    [SerializeField] private Transform smashPointA;
    [SerializeField] private Transform smashPointB;
    [SerializeField] private LayerMask smashLayer;

    [Header("設定")]
    [SerializeField] private float moveSpeed = 8;
    [SerializeField] private float jumpSpeed = 10;
    [SerializeField] private float fallMultiplier = 2.5f;
    [SerializeField] private float lowJumpMultiplier = 2f;

    [SerializeField] private float tossForce = 5;
    [SerializeField] private float smashForce = 10;

    private float xInput;

    [Header("檢測")]
    [SerializeField] private Transform foot;
    [SerializeField] private LayerMask groundLayer;
    //[SerializeField] private int jumpCount = 1;

    [Header("粒子")]
    [SerializeField] private ParticleSystem tossParticle;

    private bool canJump;
    private bool isJumping;
    private bool isSmashing;
    private bool smashOnce;
    private int smashCount = 1;
    private bool isBlocking;
    private bool isGrounded;
    private bool lastGrounded;

    private void Awake()
    {
        rb = GetComponent<Rigidbody>();
    }
    
    private void Update()
    {
        if(!GameManager.Instance.isGaming) return;

        isGrounded = Physics.CheckSphere(foot.position, 0.2f, groundLayer);
        xInput = Input.GetAxisRaw(horizontalInputString);

        if (isGrounded == true && lastGrounded == false)
        {
            OnTouchGround();
        }

        if (Input.GetButtonDown(jumpInputString) && isGrounded)
        {
            Jump();
        }
            
        if (Input.GetButtonDown(smashInputString) && CanSmash())
        {
            Smash();
        }

        if (Input.GetButtonDown(blockInputString))
        {
            
        }

        BetterJump();
        Move();

        animator.SetFloat("velecityY", rb.velocity.y);
        lastGrounded = isGrounded;
    }

    private void Move()
    {
        if(xInput > 0)
            spriteRenderer.flipX = true;
        else if(xInput < 0)
            spriteRenderer.flipX = false;
        
        if(xInput != 0)
            animator.SetBool("Move", true);
        else
            animator.SetBool("Move", false);
        rb.velocity = new Vector3(xInput * moveSpeed, rb.velocity.y, 0);
    }

    private void BetterJump()
    {
        if(rb.velocity.y < 0)
        {
            rb.velocity += Vector3.up * Physics.gravity.y * (fallMultiplier - 1) * Time.deltaTime;
        }
        else if(rb.velocity.y > 0 && !Input.GetButton(jumpInputString))
        {
            rb.velocity += Vector3.up * Physics.gravity.y * (lowJumpMultiplier - 1) * Time.deltaTime;
        }
    }

    private void OnTouchGround()
    {
        smashCount = 1;
        isJumping = false;
        isSmashing = false;
        smashOnce = false;
        animator.SetBool("Jump", false);
    }

    private void Jump()
    {
        isJumping = true;
        rb.AddForce(new Vector3(0, jumpSpeed, 0), ForceMode.Impulse);
        SoundManager.Instance.PlaySound("toss");
        animator.SetBool("Jump", true);
    }

    public bool CanSmash()
    {
        return !isSmashing && !isBlocking && !isGrounded && isJumping && smashCount > 0;
    }

    private void Smash()
    {
        isSmashing = true;
        animator.SetBool("Smash", true);
        smashCount --;
    }

    public void OnSmashAnimationEnd()
    {
        isSmashing = false;
        animator.SetBool("Smash", false);
    }

    private bool CanBlock()
    {
        return true;
    }
    private void Block()
    {
        isBlocking = true;
    }
    
    private void OnCollisionEnter(Collision collision)
    {
       if(collision.collider.CompareTag("Ball"))
        {

            Ball ballRB = collision.collider.GetComponent<Ball>();
            if(isBlocking)
            {
                SoundManager.Instance.PlaySound("block");
            }
            else if(isSmashing && !smashOnce)
            {
                Vector3 smashDir = team == PlayerTeam.Left ? new Vector3(1, -1, 0) : new Vector3(-1, -1, 0);
                if(collision.transform.position.y <= 3.5f)
                {
                    float smashAngle = 10;
                    float smashDeg = smashAngle * Mathf.Deg2Rad;
                    float x = team == PlayerTeam.Left ? Mathf.Cos(smashDeg): -Mathf.Cos(smashDeg);
                    float y = -Mathf.Sin(smashDeg);
                    Vector3 dir = new Vector3(x, y, 0);
                    ballRB.rb.velocity = dir * smashForce;
                }
                else
                {
                    int step = 10;
                    Vector3 pointA = smashPointA.position;
                    Vector3 pointB = smashPointB.position;
                    Vector3 perDir = (pointB-pointA) / step;
                    Vector3 targetA = pointA;
                    RaycastHit raycastHit;

                    for(int i = 0; i < step + 1; i++)
                    {
                        Vector3 startPoint = collision.transform.position;
                        Vector3 tempPoint = pointA + perDir * i;
                        Vector3 rayDir = tempPoint - startPoint;
                        if(Physics.SphereCast(startPoint, 0.5f, rayDir, out raycastHit, smashLayer))
                        {
                            continue;
                        }
                        else
                        {
                            targetA = raycastHit.point;
                            break;
                        }
                    }

                    Vector3 smashPoint = new Vector3(Random.Range(targetA.x, pointB.x), 0, 0);
                    smashDir = smashPoint - collision.transform.position;
                    smashDir.Normalize();
                    ballRB.rb.velocity = smashDir * smashForce;
                }
                
                ballRB.SetStat(BallStat.Smash);
                TimeScaleManager.Instance.SlowMotion(0.2f);
                SoundManager.Instance.PlaySound("Smash");
                CameraShakeManager.Instance.Shake(smashDir);
                smashOnce =  true;
            }
            else if(isJumping)
            {
                float r = Random.Range(0.8f, 1.5f);
                Vector3 dir = team == PlayerTeam.Left ? new Vector3(1, r, 0) : new Vector3(-1, r, 0);
                ballRB.rb.velocity = dir * tossForce * Random.Range(0.6f, 1.4f);
                
                tossParticle.transform.position = collision.contacts[0].point;
                tossParticle.Play();
                SoundManager.Instance.PlaySound("toss");
            }
        }
    }
}

public enum PlayerTeam
{
    Left,
    Right
}
