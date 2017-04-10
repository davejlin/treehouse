﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlyPickup : MonoBehaviour {

	void OnTriggerEnter(Collider other) {
		if (other.CompareTag ("Player")) {
			Destroy (gameObject);
		}
	}
}
