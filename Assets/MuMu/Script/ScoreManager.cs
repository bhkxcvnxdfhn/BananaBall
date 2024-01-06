using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using TMPro;
using UnityEngine;

public class ScoreManager : MonoBehaviourSingleton<ScoreManager>
{
    [SerializeField] private TMP_Text leftScoreText;
    [SerializeField] private TMP_Text rightScoreText;

    private int leftTeamScore;
    private int rightTeamScore;

    public void ResetScore()
    {
        leftTeamScore = 0;
        rightTeamScore = 0;
        leftScoreText.text = leftScoreText.ToString();
        rightScoreText.text = rightScoreText.ToString();
    }

    public void GetScore(PlayerTeam team)
    {
        if(team == PlayerTeam.Left)
        {
            leftTeamScore ++;
            leftScoreText.text = leftScoreText.ToString();
        }
        else if(team == PlayerTeam.Right)
        {
            rightTeamScore ++;
        }
    }
}
