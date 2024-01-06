using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MonoBehaviourSingleton<T> : MonoBehaviour where T : MonoBehaviour
{
    private static T _Instance;
    public static T Instance
    {
        get
        {
            if (_Instance != null)
            {
                return _Instance;      // 已經註冊的Singleton物件
            }
            _Instance = FindObjectOfType<T>();
            //尋找已經在Scene的Singleton物件:
            if (_Instance != null)
            {
                return _Instance;
            }
            GameObject singletonObject = new GameObject("Singleton");
            _Instance = singletonObject.AddComponent<T>();
            return _Instance;
        }
    }
}
