using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ball : MonoBehaviour
{
    private Rigidbody rb;

    void Awake()
    {
        rb = GetComponent<Rigidbody>();
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.collider.CompareTag("LeftGround"))
        {
            BallSpawnManager.Instance.ResetBallPoint(BallSpawnPoint.Right);
            SoundManager.Instance.PlaySound("win");
        }
        else if(collision.collider.CompareTag("RightGround"))
        {
            BallSpawnManager.Instance.ResetBallPoint(BallSpawnPoint.Left);
            SoundManager.Instance.PlaySound("win");
        }
        else if(collision.collider.CompareTag("Wall"))
        {
            Debug.Log(rb.velocity);
            //rb.velocity = new Vector3(-rb.velocity.x, rb.velocity.y, rb.velocity.z);
        }
    }
}
