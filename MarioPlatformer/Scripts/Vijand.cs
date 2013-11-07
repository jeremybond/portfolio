using UnityEngine;
using System.Collections;

public class Vijand : MonoBehaviour {
	int richting = 1;
	
	public float speed;
	
	public bool maaktJeDood;
	public bool volgtJe;
	
	// Update is called once per frame
	void FixedUpdate () {
		if(volgtJe)
		{
			Volgen(); 
		}
		if(transform.position.y < -10)
		{
			Destroy(gameObject);
		}
		Vector3 snelheid = new Vector3();
			
		snelheid.y = rigidbody.velocity.y;
		
		snelheid.x = speed * richting;
		
		rigidbody.velocity = snelheid;
	}
	
	void OnTriggerEnter(Collider col)
	{
		
		if(volgtJe)
		{
			transform.Translate(0.5f * -richting, 0, 0);
		}
		else if (col.name == "rand")
		{
			richting = -richting; 
		}
	
	}
	void OnCollisionEnter(Collision col)
	{
		if(col.collider.name == "Enemy2")
		{
			richting = -richting;
			
		}
		if(col.collider.name == "Speler" && maaktJeDood)
		{
			Global.score = 0;
			Application.LoadLevel(0);
		}
		
	}
	
	void Volgen()
	{
	GameObject speler = GameObject.Find("Speler");
	
		if(speler.transform.position.x > transform.position.x)
		{
			richting = 1;
		}
		else 
		{
			richting = -1;
		}
	}
}

