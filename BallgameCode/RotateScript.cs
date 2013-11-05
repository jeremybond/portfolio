using UnityEngine;
using System.Collections;

public class RotateScript : MonoBehaviour {

	
	void Update () {
		transform.Rotate(new Vector3(45, 30, 15) * Time.deltaTime*2);
	}
}
