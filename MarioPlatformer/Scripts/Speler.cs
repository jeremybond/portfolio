using UnityEngine;
using System.Collections;

public class Speler : MonoBehaviour {
	bool staatOpPlatform = false;
	float tijd;// schiet tijd
	float timer;// schiet timer
	
	
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		Vector3 snelheid = new Vector3();
		
		
		snelheid.y = rigidbody.velocity.y;
		// naar links lopen
		if(Input.GetAxis("Horizontal") < 0)
		{
			snelheid.x = -10;
		}
		// naar rechts lopen
		else if(Input.GetAxis("Horizontal") > 0)
		{
			snelheid.x = 10;
		}
		
		rigidbody.velocity = snelheid;
		// er voorzorgen dat je kunt springen
		if(Input.GetAxis("Jump")> 0 && staatOpPlatform)
		{
			rigidbody.AddForce(0, 250, 0);
		}
		// doodgaan als y kleiner is dan -10
		if(transform.position.y < -10)
		{
			Global.score = 0;
			Application.LoadLevel(0);
		}
		// schieten van ander script
		
		if(Input.GetAxis("Fire1") > 0 && tijd == 0)
		{
			GameObject newObject2 = Instantiate(Resources.Load("Kogel1"), transform.position, Quaternion.identity) as GameObject;
			newObject2.transform.Translate (-1, 0, 0);
			tijd = 1f;
		}
		if(tijd > 0)
		{
			tijd -= Time.deltaTime;
			if(tijd < 0)
			{
				tijd = 0;
			}
		}
		if(Input.GetAxis("Fire2") > 0 && tijd == 0)
		{
			GameObject newObject = Instantiate(Resources.Load("Kogel2"), transform.position, Quaternion.identity) as GameObject;
			newObject.transform.Translate(1, 0, 0);
			tijd = 1f;
		}
		if(tijd > 0)
		{
			tijd -= Time.deltaTime;
			if(tijd < 0)
			{
				tijd = 0;
			}
		}
	}
	void OnTriggerEnter(Collider col)
	{	
		// destroy the enemy
		if(col.name == "Enemy" || col.name == "Enemy2")
		{
			Destroy(col.collider.gameObject);
			Destroy(gameObject);
			
		}
		// hier krijg je score erbij als je een coin raakt en verdwijnt de coin
		if(col.name == "coin")
		{
			
			Global.score += 5;
			Destroy(col.gameObject);
		}
	}
	void OnCollisionEnter(Collision col)
	{//Debug.Log("text");
		if(col.collider.name != "Enemy2" && col.collider.name != "springveer")
		{
			staatOpPlatform = true;
		}
//												enemys gaan dood als je er op springt
//		if(col.collider.name == "Enemy")
//		{
//			
//			if(col.contacts[0].normal.y > 0.8f)
//			{
//				Global.score += 10;
//				Destroy(col.collider.gameObject);
//			}
//		}
		if(col.collider.name == "Finish")
		{
			if(col.contacts[0].normal.y > 0.5f)
			{
				//Debug.Log("halllo you won");
				// hier moet staan wat er gebeurt als je de finish aanraakt
				Application.LoadLevel("Scene2");
			}
		}
		// je springt als je een springveer aanraakt
		if(col.collider.name == "springveer")
		{
			if(col.contacts[0].normal.y > 0.5f)
			{
				rigidbody.AddForce(0, 1000, 0);
			}
		}
		// je springt naar rechts als je deze aanraakt
		if(col.collider.name == "minispringveer")
		{
			if(col.contacts[0].normal.y > 0.5f)
			{
				rigidbody.AddForce(0, 750, 0);
			}
		}
		// je springt hoog als je een jumper aanraakt
		if(col.collider.name == "jumper")
		{
			if(col.contacts[0].normal.y > 0.5f)
			{
				rigidbody.AddForce(0, 2250, 0);
			}
		}
// 													je teleporteert naar een bepaalde plaats als je finish aanraakt
//		if(col.collider.name == "finish")
//		{
//			gameObject.transform.Translate(gameObject.transform.position.x + 10,0,0);
//		}
//		if(col.collider.name == "finish2")
//		{
//			gameObject.transform.Translate(gameObject.transform.position.x + 0,0,0);
//		}
		
		
		
		
	}
	void OnCollisionExit(Collision col)
	{
		if(col.collider.name != "Vijand")
		{
			staatOpPlatform = false;
		}
	}
	
	
	
}
