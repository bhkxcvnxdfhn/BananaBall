using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnityEngine;

public class SoundManager : MonoBehaviourSingleton<SoundManager>
{
    [SerializeField] private AudioSource audioSource;
    [SerializeField] private AudioClip[] sfxClips;
    public void PlaySound(string soundName)
    {
        AudioClip audioClip = sfxClips.FirstOrDefault(x => x.name.ToUpper() == soundName.ToUpper());
        if (audioClip != null)
        {
            audioSource.PlayOneShot(audioClip);
        }
        else
        {
            Debug.LogWarning($"find no sound name: {soundName}");
        }
    }

}