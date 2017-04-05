using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour {

	private Animator playerAnimator;
	private float moveHorizontal;
	private float moveVertical;
	private Vector3 movement;
	private float turningSpeed = 20f;
	private Rigidbody playerRigidbody;

	// Use this for initialization
	void Start () {
		playerAnimator = GetComponent<Animator> ();
		playerRigidbody = GetComponent<Rigidbody> ();
	}
	
	// Update is called once per frame
	void Update () {
		moveHorizontal = Input.GetAxisRaw ("Horizontal");
		moveVertical = Input.GetAxisRaw ("Vertical");

		movement = new Vector3 (moveHorizontal, 0.0f, moveVertical);
	}

	void FixedUpdate() {
		if (movement != Vector3.zero) {
			Quaternion targetRotation = Quaternion.LookRotation (movement, Vector3.up);
			Quaternion newRotation = Quaternion.Lerp (playerRigidbody.rotation, targetRotation, turningSpeed * Time.deltaTime);
			playerRigidbody.MoveRotation (newRotation);
			playerAnimator.SetFloat ("Speed", 3f);
		} else {
			playerAnimator.SetFloat ("Speed", 0f);
		}
	}
}
