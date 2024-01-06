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

    private float xInput;

    [SerializeField] private Transform foot;
    [SerializeField] private LayerMask groundLayer;
    [SerializeField] private int jumpCount = 2;
    private bool canJump;
    private bool isJumping;
    private bool isGrounded;

    private void Awake()
    {
        rb = GetComponent<Rigidbody>();
    }

    private void Update()
    {
        isGrounded = Physics.CheckSphere(foot.position, 0.2f, groundLayer);
        xInput = Input.GetAxisRaw(horizontalInputString);


        if (Input.GetButtonDown(jumpInputString) && isGrounded)
            Jump();

        Move();
    }

    private void Jump()
    {
        rb.AddForce(new Vector3(0, jumpSpeed, 0), ForceMode.Impulse);
    }

    private void Move()
    {
        rb.velocity = new Vector3(xInput * moveSpeed, rb.velocity.y, 0);
    }

    private void OnCollisionEnter(Collision collision)
    {
        if(isj)
    }
}

public enum PlayerTeam
{
    Left,
    Right
}
