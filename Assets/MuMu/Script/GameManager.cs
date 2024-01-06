using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class GameManager : MonoBehaviourSingleton<GameManager>
{
    [SerializeField] private TMP_Text prepareTimeText;
    [SerializeField] private TMP_Text timeText;
    [SerializeField] private TMP_Text winText;

    [SerializeField] private float gameTime = 120;
    [SerializeField] private float prepareTime = 4;

    private bool isGaming;
    private bool isBallPrepare;
    private float gameTimer;
    private float prepareTimer;

    private void Start()
    {
        GameStart();
    }

    void Update()
    {
        if(isGaming)
        {
            if(isBallPrepare)
            {
                prepareTimer-=Time.deltaTime;
                int intPrepareTimer = Mathf.CeilToInt(prepareTimer);
                prepareTimeText.text = intPrepareTimer.ToString();

                if(prepareTimer <= 0)
                {
                    prepareTimeText.gameObject.SetActive(false);
                    BallSpawnManager.Instance.StartBall();
                    isBallPrepare = false;
                }
            }
            else
            {
                gameTimer -= Time.deltaTime;
                timeText.text = GetTime();
            }

            if(gameTimer <= 0)
            {
                GameEnd();
            }
        }
    }

    private string GetTime()
    {
        float mid = gameTimer / 60f;
        float second = gameTimer % 60;
        return mid.ToString("00") + ":" + second.ToString("00");
    }

    private void GameStart()
    {
        isGaming = true;
        prepareTimer = prepareTime;
        gameTimer = gameTime;
        BallSpawnManager.Instance.SpawnBall(BallSpawnPoint.Center);
        BallPrepare();
    }

    public void BallPrepare()
    {
        isBallPrepare = true;
        prepareTimer = prepareTime;
        prepareTimeText.gameObject.SetActive(true);
        prepareTimeText.text = prepareTimer.ToString();
    }

    private void GameEnd()
    {
        bool leftWin = ScoreManager.Instance.leftTeamScore > ScoreManager.Instance.rightTeamScore;
        if(leftWin)
        {
            
        }
        else
        {

        }
        isGaming = false;
    }
}
