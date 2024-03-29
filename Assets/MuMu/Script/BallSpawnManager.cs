using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class BallSpawnManager : MonoBehaviourSingleton<BallSpawnManager>
{
    [SerializeField] private GameObject ballPrefab;

    [SerializeField] private Transform leftTeamPoint;
    [SerializeField] private Transform rightTeamPoint;
    [SerializeField] private Transform centerPoint;

    private GameObject ball;
    private Rigidbody rb;

    public void SpawnBall(BallSpawnPoint spawnPoint)
    {
        if(ball == null)
        {
            CreateBall(spawnPoint);
            StopBall();
        }
        else
        {
            ResetBallPoint(spawnPoint);
        }
    }

    public void ResetBallPoint(BallSpawnPoint spawnPoint) 
    {
        if (ball == null)
        {
            CreateBall(spawnPoint);
            return;
        }

        if (spawnPoint == BallSpawnPoint.Left)
        {
            ball.transform.position = leftTeamPoint.position;
        }
        else if(spawnPoint == BallSpawnPoint.Right)
        {
            ball.transform.position = rightTeamPoint.position;
        }
        else if(spawnPoint == BallSpawnPoint.Center)
        {
            ball.transform.position = centerPoint.position;
        }
        StopBall();
    }

    private void CreateBall(BallSpawnPoint spawnPoint)
    {
        if (spawnPoint == BallSpawnPoint.Left)
        {
            ball = Instantiate(ballPrefab, leftTeamPoint.position, Quaternion.identity);
        }
        else if (spawnPoint == BallSpawnPoint.Right)
        {
            ball = Instantiate(ballPrefab, rightTeamPoint.position, Quaternion.identity);
        }
        else if (spawnPoint == BallSpawnPoint.Center)
        {
            ball = Instantiate(ballPrefab, centerPoint.position, Quaternion.identity);
        }
        rb = ball.GetComponent<Rigidbody>();
    }

    public void StartBall()
    {
        rb.isKinematic = false;
    }

    public void StopBall()
    {
        rb.isKinematic = true;
    }
}

public enum BallSpawnPoint
{
    Left,
    Center,
    Right
}
