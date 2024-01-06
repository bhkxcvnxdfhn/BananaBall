using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ball : MonoBehaviour
{
    [SerializeField] private ParticleSystem smashEffect;
    [SerializeField] private ParticleSystem hitParticle;
    public Rigidbody rb;
    private BallStat ballStat = BallStat.Normal;

    void Awake()
    {
        rb = GetComponent<Rigidbody>();
    }

    void Update()
    {
        if(ballStat == BallStat.Smash)
        {
            smashEffect.transform.forward = rb.velocity;
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.collider.CompareTag("LeftGround"))
        {
            BallSpawnManager.Instance.ResetBallPoint(BallSpawnPoint.Right);
            ScoreManager.Instance.GetScore(PlayerTeam.Right);
            SoundManager.Instance.PlaySound("win");
            GameManager.Instance.BallPrepare();
        }
        else if(collision.collider.CompareTag("RightGround"))
        {
            BallSpawnManager.Instance.ResetBallPoint(BallSpawnPoint.Left);
            ScoreManager.Instance.GetScore(PlayerTeam.Left);
            SoundManager.Instance.PlaySound("win");
            GameManager.Instance.BallPrepare();
        }

        if(ballStat == BallStat.Smash)
        {
            SetStat(BallStat.Normal);
        }
        
        if(!collision.collider.CompareTag("Player"))
        {
            hitParticle.transform.position = collision.contacts[0].point + collision.contacts[0].normal * 0.1f;
            hitParticle.transform.forward = collision.contacts[0].normal;
            hitParticle.Play();
        }
    }

    public void SetStat(BallStat ballStat)
    {
        this.ballStat = ballStat;
        if(ballStat == BallStat.Normal)
        {
            smashEffect.Stop(true, ParticleSystemStopBehavior.StopEmitting);
        }
        else if(ballStat == BallStat.Smash)
        {
            smashEffect.gameObject.SetActive(true);
            smashEffect.Play();
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
