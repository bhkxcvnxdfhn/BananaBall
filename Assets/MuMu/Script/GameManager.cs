using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviourSingleton<GameManager>
{
    private void Start()
    {
        BallSpawnManager.Instance.SpawnBall(BallSpawnPoint.Center);
    }
}
