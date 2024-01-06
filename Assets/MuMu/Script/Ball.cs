using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ball : MonoBehaviour
{
    [SerializeField] private GameObject smashEffect;
    private Rigidbody rb;
    private BallStat ballStat;

    void Awake()
    {
        rb = GetComponent<Rigidbody>();
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.collider.CompareTag("LeftGround"))
        {
            BallSpawnManager.Instance.ResetBallPoint(BallSpawnPoint.Right);
        }
        else if(collision.collider.CompareTag("RightGround"))
        {
            BallSpawnManager.Instance.ResetBallPoint(BallSpawnPoint.Left);
        }
        else if(collision.collider.CompareTag("Wall"))
        {
            Debug.Log(rb.velocity);
            //rb.velocity = new Vector3(-rb.velocity.x, rb.velocity.y, rb.velocity.z);
        }
    }

    public void SetStat(BallStat ballStat)
    {
        this.ballStat = ballStat;
        if(ballStat == BallStat.Normal)
        {
            smashEffect.SetActive(false);
        }
        else if(ballStat == BallStat.Smash)
        {
            smashEffect.SetActive(true);
        }
        else if(ballStat == BallStat.Block)
        {

        }
    }
}

public enum BallStat
{
    Normal,
    Smash,
    Block,
}
