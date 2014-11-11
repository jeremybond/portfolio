using UnityEngine;
using System.Collections;

public class ObstacleMovement : MonoBehaviour {
	float downForce;

	void FixedUpdate () {
		float score = (IngameGui.totalScore / 15000);
		downForce = (score + 3);
		rigidbody.velocity = new Vector3(0, -downForce, 0);
	}
}
