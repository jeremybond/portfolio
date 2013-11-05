using UnityEngine;
using System.Collections;

public class CameraBehaviourScript : MonoBehaviour {

	public GameObject player;
	private Vector3 offset;
	public float scrollSpeed;
	public Transform target;
	
	void Start()
	{
		offset = transform.position;
		scrollSpeed = 100;
		
	}
	void Update()
	{
		//transform.LookAt(target);
	}
	void LateUpdate()
	{
		//float mouseScroll = Input.GetAxis("Mouse ScrollWheel");
		transform.position = player.transform.position + offset;
		//transform.Rotate(0.0f, mouseScroll * scrollSpeed, 0.0f);
		//transform.LookAt(target);
	}
	
}
