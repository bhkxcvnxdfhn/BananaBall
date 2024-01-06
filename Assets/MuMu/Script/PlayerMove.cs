using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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

    private bool canJump;
    private bool isJumping;
    private bool isSmashing;
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
            StartCoroutine(Smash());
        }

        if (Input.GetButtonDown(blockInputString))
        {
            
        }

        BetterJump();
        Move();
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
    }

    private void Jump()
    {
        isJumping = true;
        rb.AddForce(new Vector3(0, jumpSpeed, 0), ForceMode.Impulse);
    }

    public bool CanSmash()
    {
        return !isSmashing && !isBlocking && !isGrounded && isJumping && smashCount > 0;
    }

    private IEnumerator Smash()
    {
        isSmashing = true;
        yield return new WaitForSeconds(1);
        isSmashing = false;
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
       if(collision.collider.CompareTag("Ball") && isJumping)
        {
            Rigidbody ballRB = collision.collider.GetComponent<Rigidbody>();
            if(isBlocking)
            {

            }
            else if(isSmashing)
            {
                float smashAngle = 10;
                float smashDeg = smashAngle * Mathf.Deg2Rad;
                float x = team == PlayerTeam.Left ? Mathf.Cos(smashDeg): -Mathf.Cos(smashDeg);
                float y = -Mathf.Sin(smashDeg);
                Vector3 dir = new Vector3(x, y, 0);
                ballRB.velocity = dir * smashForce;
            }
            else if(isJumping)
            {
                Vector3 dir = team == PlayerTeam.Left ? new Vector3(1, 1, 0) : new Vector3(-1, 1, 0);
                ballRB.velocity = dir * tossForce;
            }
        }
    }
}

public enum PlayerTeam
{
    Left,
    Right
}
