using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ball : MonoBehaviour
{
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
    }
}
