using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine;

public class CameraShakeManager : MonoBehaviourSingleton<CameraShakeManager>
{
    [SerializeField] public CinemachineImpulseSource source;
    
    public void Shake()
    {
        source.GenerateImpulse();
    }

    public void Shake(Vector3 velocity)
    {
        source.GenerateImpulse(velocity);
    }
}