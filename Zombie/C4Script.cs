using UnityEngine;
using System.Collections;

public class C4Script : MonoBehaviour {
 public float timer = 5;
 public float Damage;
	
	
 	void Update () {
 	timer -= Time.deltaTime;
  
  
 	}
 	void OnTriggerStay(Collider col)
 	{
	  	if(timer <= 0)
	  	{
		   	Instantiate(Resources.Load("BombSystem"), transform.position, Quaternion.identity);
		   	if(col.collider.gameObject.name == "Player")
		   	{
		    	col.collider.gameObject.GetComponent<PlayerScript>().TakeDamage(Damage);
		   	}
		   	if(col.collider.gameObject.name == "Zombie")
			{  
		    	col.collider.gameObject.GetComponent<ZombieScript>().TakeDamage(50, "");
		   	}
   
		}
 	}
   
}