using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationTraisition : MonoBehaviour
{
    public PlayerMove playerMove;
    public void Smash()
    {
        playerMove.OnSmashAnimationEnd();
    }
}
