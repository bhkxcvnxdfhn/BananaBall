using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMove : MonoBehaviour
{
    private Rigidbody rb;

    [SerializeField] private PlayerTeam team;
    [SerializeField] private string horizontalInputString;
    [SerializeField] private string jumpInputString;

    [SerializeField] private float moveSpeed = 8;
    [SerializeField] private float jumpSpeed = 10;

    [SerializeField] private float pushForce = 10;

    private float xInput;

    [SerializeField] private Transform foot;
    [SerializeField] private LayerMask groundLayer;
    [SerializeField] private int jumpCount = 2;

    private bool canJump;
    private bool isJumping;
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

        if (isJumping && isGrounded == true && lastGrounded == false)
        {
            isJumping = false;
        }

        if (Input.GetButtonDown(jumpInputString) && isGrounded)
            Jump();

        Move();
        lastGrounded = isGrounded;
    }

    private void Jump()
    {
        isJumping = true;
        rb.AddForce(new Vector3(0, jumpSpeed, 0), ForceMode.Impulse);
    }

    private void Move()
    {
        rb.velocity = new Vector3(xInput * moveSpeed, rb.velocity.y, 0);
    }

    private void OnCollisionEnter(Collision collision)
    {
       if(collision.collider.CompareTag("Ball") && isJumping)
        {
            if(team == PlayerTeam.Left)
            {
                Vector3 dir = new Vector3(1, 1, 0);
                Rigidbody ballRB = collision.collider.GetComponent<Rigidbody>();
                ballRB.velocity = dir * pushForce;
            }
            else if(team == PlayerTeam.Right)
            {
                Vector3 dir = new Vector3(-1, 1, 0);
                Rigidbody ballRB = collision.collider.GetComponent<Rigidbody>();
                ballRB.velocity = dir * pushForce;
            }
        }
    }
}

public enum PlayerTeam
{
    Left,
    Right
}
