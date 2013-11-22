using UnityEngine;
using System.Collections;

public class Crypt : MonoBehaviour {
	
	bool spawn;
	GameObject player;
	public float counter;
	// Use this for initialization
	void Start () {
		counter = 1.5f;
		player = GameObject.Find("Player");
	}
	void FixedUpdate () {
		rigidbody.velocity = Vector3.zero;
		counter -= 1* Time.deltaTime;
		if(counter <= 0)
		{
			if(spawn)
			{
				float number = Random.value;
				string zombieName = "";
				
				if(number > 0.2f)
				{
					zombieName = "Zombie";
				}
				else
				{
					zombieName = "Boomer";
				}
				GameObject newZombie = Instantiate(Resources.Load(zombieName), transform.position, Quaternion.identity) as GameObject;	
				newZombie.name = "Zombie";
				newZombie.transform.Rotate(0, Random.value * 360, 0);
				newZombie.transform.Translate(0, 1, 5);
			}
			counter = 1.5f;
		}
	}
	// Update is called once per frame
	void Update () {
		
		if (Vector3.Distance(transform.position, player.transform.position) < 35)
		{
			spawn = true;
		}
		if (Vector3.Distance(transform.position, player.transform.position) > 20)
		{
			spawn = false;
		}
		
	}
		
}
