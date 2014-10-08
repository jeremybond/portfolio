using UnityEngine;
using System.Collections;

public class AcceleroMeterInput : MonoBehaviour {
	private Vector3 accelerationInput;
	private Vector3 Speed = new Vector3(0.08f, 0, 0);
	void Update () {
		accelerationInput = Input.acceleration;
	}
	void Start()
	{
		StartCoroutine(CheckNewPos());
	}
	IEnumerator CheckNewPos(){
		MovePlayer();
		yield return new WaitForSeconds(0.002f);
		StartCoroutine(CheckNewPos());
	}
	private void MovePlayer()
	{
		if(accelerationInput.x < -0.2f && transform.position.x > -3)
		{

			transform.position -= -accelerationInput.x * Speed;
		}else if(accelerationInput.x > 0.2f && transform.position.x < 3)
		{
			transform.position += accelerationInput.x * Speed;
		}
	}
}
