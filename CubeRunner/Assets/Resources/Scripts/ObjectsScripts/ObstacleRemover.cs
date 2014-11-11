using UnityEngine;
using System.Collections;

public class ObstacleRemover : MonoBehaviour {

	void OnCollisionEnter(Collision col)
	{
		Destroy(col.gameObject);
	}
}
