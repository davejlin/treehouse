using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class BirdMovement : MonoBehaviour {

	[SerializeField]
	private Transform target;

	[SerializeField]
	private RandomSoundPlayer birdFootsteps;

	private NavMeshAgent birdAgent;
	private Animator birdAnimator;

	// Use this for initialization
	void Start () {
		birdAgent = GetComponent<NavMeshAgent> ();
		birdAnimator = GetComponent<Animator> ();
	}
	
	// Update is called once per frame
	void Update () {
		birdAgent.SetDestination (target.position);
		float speed = birdAgent.velocity.magnitude;
		birdAnimator.SetFloat ("Speed", speed);

		if (speed > 0f) {
			birdFootsteps.enabled = true;
		} else {
			birdFootsteps.enabled = false;
		}
	}
}
