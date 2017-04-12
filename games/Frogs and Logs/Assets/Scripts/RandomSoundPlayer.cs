using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomSoundPlayer : MonoBehaviour {

	[SerializeField]
	private List<AudioClip> soundClips = new List<AudioClip>();

	private AudioSource audioSource;
	private float soundTimerDelay = 3f;
	private float soundTimer;

	// Use this for initialization
	void Start () {
		audioSource = GetComponent<AudioSource> ();
	}
	
	// Update is called once per frame
	void Update () {
		soundTimer += Time.deltaTime;
		if (soundTimer >= soundTimerDelay) {
			soundTimer = 0f;
			AudioClip randomSound = soundClips[Random.Range (0, soundClips.Count)];
			audioSource.PlayOneShot (randomSound);
		}
	}
}
