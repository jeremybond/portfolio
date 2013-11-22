using UnityEngine;
using System.Collections;

public class ZombieScript : MonoBehaviour {
	public AudioClip death;
	public float Damage;
	
	
	bool aggro;
	GameObject player;
	public int hitpoints;
	
	void Start()
	{
		player = GameObject.Find("Player");
		
		transform.position = new Vector3(transform.position.x, 0, transform.position.z);
	}
	
	void FixedUpdate()
	{
		rigidbody.velocity = Vector3.zero;
		if(aggro)
		{
			rigidbody.velocity = Vector3.zero;
			transform.LookAt(player.transform.position);
			rigidbody.AddRelativeForce(0, 50, 100);
		}
	}
	void Update()
	{
		if(Vector3.Distance(transform.position, player.transform.position) < 10)
		{
			aggro = true;
		}else if(Vector3.Distance(transform.position, player.transform.position) > 20){
			aggro = false;
		}
	}
	public void TakeDamage(int damage, string deathSound)
	{
		hitpoints -= damage;
		
		if (hitpoints <= 0)
		{
			if (deathSound == "swordSlice")
			{
				AudioSource.PlayClipAtPoint(death, transform.position, 1);
			}
			
			Instantiate(Resources.Load("Blood"), transform.position, Quaternion.identity);	
			Destroy(gameObject);	
		}
	}
	void OnCollisionStay(Collision col)
	{
		if(col.collider.gameObject.name == "Player")
		{
			col.collider.gameObject.GetComponent<PlayerScript>().TakeDamage(Damage);
		}
	}
}
