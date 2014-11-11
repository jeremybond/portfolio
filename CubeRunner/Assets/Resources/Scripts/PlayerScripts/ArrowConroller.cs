using UnityEngine;
using System.Collections;

public class ArrowConroller : MonoBehaviour {
	private Vector3 Speed = new Vector3(0.06f, 0, 0);
	void Start()
	{
		StartCoroutine(CheckNewPos());
	}
	IEnumerator CheckNewPos(){
		//NewPositionCalculator();
		yield return new WaitForSeconds(0.005f);
		//StartCoroutine(CheckNewPos());
	}
	void Update(){
		NewPositionCalculator();
	}
	private void NewPositionCalculator()
	{
		float horizontalMovement = Input.GetAxis("Horizontal");
		if(horizontalMovement < -0.2f && transform.position.x > -3)
		{
			transform.position -= Speed;
		}else if(horizontalMovement > 0.2f && transform.position.x < 3)
		{
			transform.position += Speed;
		}
	}
}
