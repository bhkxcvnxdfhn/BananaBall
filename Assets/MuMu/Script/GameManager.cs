using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class GameManager : MonoBehaviourSingleton<GameManager>
{
    [SerializeField] private Transform leftSpawnPoint;
    [SerializeField] private Transform rightSpawnPoint;
    [SerializeField] private Transform leftPlayer;
    [SerializeField] private Transform rightPlayer;
    [SerializeField] private TMP_Text prepareTimeText;
    [SerializeField] private TMP_Text timeText;
    [SerializeField] private TMP_Text win01Text;
    [SerializeField] private TMP_Text win02Text;
    [SerializeField] private TMP_Text win01ScoreText;
    [SerializeField] private TMP_Text win02ScoreText;
    [SerializeField] private GameObject preparePanel;
    [SerializeField] private GameObject winPanel;
    [SerializeField] private GameObject startPanel;
    [SerializeField] private GameObject focusCamera;

    [SerializeField] private float gameTime = 120;
    [SerializeField] private float prepareTime = 4;

    public bool isGaming;
    private bool isBallPrepare;
    private float gameTimer;
    private float prepareTimer;

    /// <summary>
    /// Start is called on the frame when a script is enabled just before
    /// any of the Update methods is called the first time.
    /// </summary>
    void Start()
    {
        startPanel.SetActive(true);
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
                    preparePanel.SetActive(false);
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
        int mid = (int)gameTimer / 60;
        int second = (int)gameTimer % 60;
        return mid.ToString("00") + ":" + second.ToString("00");
    }

    
    public void GameStart()
    {
        StartCoroutine(GameStartCo());
    }

    private IEnumerator GameStartCo()
    {
        focusCamera.SetActive(false);
        winPanel.SetActive(false);
        startPanel.SetActive(false);
        leftPlayer.position = leftSpawnPoint.position;
        rightPlayer.position = rightSpawnPoint.position;
        prepareTimer = prepareTime;
        gameTimer = gameTime;
        timeText.text = GetTime();
        ScoreManager.Instance.ResetScore();

        yield return new WaitForSeconds(2);
        isGaming = true;
        BallSpawnManager.Instance.SpawnBall(BallSpawnPoint.Left);
        BallPrepare();
    }

    public void BallPrepare()
    {
        isBallPrepare = true;
        prepareTimer = prepareTime;
        preparePanel.SetActive(true);
        prepareTimeText.text = prepareTimer.ToString();
    }

    private void GameEnd()
    {
        StartCoroutine(GameEndCO());
    }

    private IEnumerator GameEndCO()
    {
        focusCamera.SetActive(true);
        isGaming = false;
        
        BallSpawnManager.Instance.ResetBallPoint(BallSpawnPoint.Left);

        yield return new WaitForSeconds(2);

        bool leftWin = ScoreManager.Instance.leftTeamScore > ScoreManager.Instance.rightTeamScore;
        winPanel.SetActive(true);
        if(leftWin)
        {
            win01Text.text = "Win";
            win01Text.color = Color.green;
            win02Text.text = "Lose";
            win02Text.color = Color.red;
        }
        else
        {
            win01Text.text = "Lose";
            win02Text.color = Color.red;
            win02Text.text = "Win";
            win02Text.color = Color.green;
        }

        win01ScoreText.text = "Score:" + ScoreManager.Instance.leftTeamScore.ToString();
        win02ScoreText.text = "Score:" + ScoreManager.Instance.rightTeamScore.ToString();
    }
}
