using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TimeScaleManager : MonoBehaviourSingleton<TimeScaleManager>
{
    public void SlowMotion(float time)
    {
        StartCoroutine(SlowMotionCO(time));
    }

    private IEnumerator SlowMotionCO(float time)
    {
        Time.timeScale = 0.1f;
        yield return new WaitForSecondsRealtime(time);
        Time.timeScale = 1f;
    }
}
