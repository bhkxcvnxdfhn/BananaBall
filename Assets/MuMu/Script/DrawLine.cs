using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrawLine : MonoBehaviour
{
/// <summary>
    /// 引导线
    /// </summary>
    public LineRenderer _lr;

    /// <summary>
    /// 刚体
    /// </summary>
    public Rigidbody _rb;

    /// <summary>
    /// 跨度
    /// </summary>
    public float timeBeteenStep = 1;

    /// <summary>
    /// 跨度数量
    /// </summary>
    public int stepCount = 30;
    
    /// <summary>
    /// 加速度
    /// </summary>
    public Vector3 addedV, addedF;

    void Start() {
        
        //找引导线
        _lr = GetComponent<LineRenderer>();
        //找刚体
        _rb = GetComponent<Rigidbody>();
    }

    public void AddPower(Vector3 dir)
    {
        CalcTime();
        _rb.velocity += addedV;
        addedV = Vector3.zero;
        _rb.AddForce(dir, ForceMode.Force);
        addedF = Vector3.zero;
    }


    private void CalcTime()
    {

        Vector3[] t = _rb.CalculateTime(new Vector3(0, 0, 0),
            addedV, addedF);

        var timeT = new Vector3[]{
            new Vector3(Time.time + t[0].x, Time.time + t[0].y, Time.time + t[0].z),
            new Vector3(Time.time + t[1].x, Time.time + t[1].y, Time.time + t[1].z)
        };
    }

    #region 抛物曲线

    /// <summary>
    /// 移动走向曲线
    /// </summary>
    private void DrawMovementLine()
    {
        var res = _rb.CalculateMovement(stepCount, timeBeteenStep, addedV, addedF);
        _lr.positionCount = stepCount + 1;
        _lr.SetPosition(0, transform.position);
        for (int i = 0; i < res.Length; ++i)
        {
            _lr.SetPosition(i + 1, res[i]);
        }
    }

    #endregion

    void Update ()
    {
        DrawMovementLine();
    }
}

// ————————————————
// 版权声明：本文为CSDN博主「类人_猿」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
// 原文链接：https://blog.csdn.net/qq_42194657/article/details/105153467
