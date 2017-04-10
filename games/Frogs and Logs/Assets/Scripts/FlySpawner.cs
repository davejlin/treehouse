using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlySpawner : MonoBehaviour {

	[SerializeField]
	private GameObject flyPrefab;

	[SerializeField]
	private int totalFlyMinimum = 12;

	private float spawnArea = 25f;

	public static int totalFlies;

	// Use this for initialization
	void Start () {
		totalFlies = 0;
	}
	
	// Update is called once per frame
	void Update () {
		while (totalFlies < totalFlyMinimum) {
			totalFlies++;
			float positionX = Random.Range (-spawnArea, spawnArea);
			float positionZ = Random.Range (-spawnArea, spawnArea);
			Vector3 flyPosition = new Vector3 (positionX, 2f, positionZ);
			Instantiate (flyPrefab, flyPosition, Quaternion.identity);
		}
	}
}
