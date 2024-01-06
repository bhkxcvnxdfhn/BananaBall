using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BallSpawnManager : MonoBehaviourSingleton<BallSpawnManager>
{
    [SerializeField] private GameObject ballPrefab;

    [SerializeField] private Transform leftTeamPoint;
    [SerializeField] private Transform rightTeamPoint;
    [SerializeField] private Transform centerPoint;

    private GameObject ball;

    public void SpawnBall(BallSpawnPoint spawnPoint)
    {
        if(ball == null)
        {
            CreateBall(spawnPoint);
        }

        ResetBallPoint(spawnPoint);
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
    }

    private void CreateBall(BallSpawnPoint spawnPoint)
    {
        ball = Instantiate(ballPrefab);
    }
}

public enum BallSpawnPoint
{
    Left,
    Center,
    Right
}
