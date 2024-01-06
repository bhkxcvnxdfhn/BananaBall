using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using TMPro;
using UnityEngine;

public class ScoreManager : MonoBehaviourSingleton<ScoreManager>
{
    [SerializeField] private TMP_Text leftScoreText;
    [SerializeField] private TMP_Text rightScoreText;

    public int leftTeamScore;
    public int rightTeamScore;

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
            leftScoreText.text = leftTeamScore.ToString();
            leftScoreText.transform.DOPunchScale(new Vector3(1, 1, 0), 0.2f, 4);
        }
        else if(team == PlayerTeam.Right)
        {
            rightTeamScore ++;
            rightScoreText.text = rightTeamScore.ToString();
            rightScoreText.transform.DOPunchScale(new Vector3(1, 1, 0), 0.2f, 4);
        }
    }
}
