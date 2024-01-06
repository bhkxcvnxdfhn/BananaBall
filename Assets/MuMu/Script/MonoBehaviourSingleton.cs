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
                return _Instance;      // �w�g���U��Singleton����
            }
            _Instance = FindObjectOfType<T>();
            //�M��w�g�bScene��Singleton����:
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
