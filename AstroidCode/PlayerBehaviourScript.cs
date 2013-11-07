using UnityEngine;
using System.Collections;

public class PlayerBehaviourScript : MonoBehaviour {
	
	public float speed;
	public float rotationSpeed;
	public float shootTime;
	public GameObject bullet;
	public GameObject astroid;
	public GameObject enemyShip;
	public float astroidSpawnTimer;
	public int randomNumb1;
	public int randomNumb2;
	public int totalScore;
	public GUIText scoreCounter;
	public GUIText lifeCounter;
	public float playerX;
	public float playerZ;
	public float puntenTimer;
	public float lifeTimer;
	public float totalLife;
	public float enemyShipSpawnTimer;
	
	void Start(){
		////////////setting the timers/////////////
		shootTime = 0;
		enemyShipSpawnTimer = 5;//20
		////////////timer for Spawning Astroids////
		astroidSpawnTimer = 1;
		////////////The Astroid spawn Function/////
		spawnAstroid();
		spawnEnemyShip();
		////////////Set the Score and life/////////
		totalScore = -1;
		totalLife = 6;
		////////////Set The GUI Text///////////////
		SetCountText();
		SetLifeText();
		////////////Set the Timer//////////////////
		puntenTimer = 0;
		lifeTimer = 0;
	}
	public void SetLifeText()
	{
		if(lifeTimer <= 0)
		{
			totalLife = totalLife - 1;
			lifeTimer = 0.5f;
			if(totalLife<=0)
			{
				Destroy(gameObject);
			}
		}	
		lifeCounter.text = "Life: " + totalLife;
	}
	public void SetCountText()
	{
		if(puntenTimer <= 0)
		{
			totalScore= totalScore + 1;
			puntenTimer = 0.2f;
		}
		scoreCounter.text = "Score: " + totalScore;
	}
	
	void FixedUpdate () {
		///////////////EnemyShipSpawn/////
		spawnEnemyShip();
		///////////////AstroidSpawn///////
		spawnAstroid();
		///////////////setting Timers/////
		if(puntenTimer  > 0)
		{
			puntenTimer -= Time.deltaTime;
		}
		if(lifeTimer > 0)
		{
			lifeTimer -= Time.deltaTime;
		}
		if(enemyShipSpawnTimer > 0)
		{
			enemyShipSpawnTimer -= Time.deltaTime;
		}
		///////////////////Walk//////////////
		float z = Input.GetAxis("Vertical");
		
		Vector3 movement = new Vector3(0.0f, 0.0f, z);
		
		rigidbody.AddRelativeForce(movement * speed * Time.deltaTime);
		
		float x = Input.GetAxis("Horizontal");
		transform.Rotate(0, x * rotationSpeed * Time.deltaTime, 0);
		
		
		/////////////////Fire////////////////
		float shoot = Input.GetAxis("Fire1");
		
		if(shootTime > 0)
		{
			shootTime -= Time.deltaTime;
		}
		if(shoot > 0 && shootTime<=0)
		{
			GameObject newBull = Instantiate(bullet, transform.position, transform.rotation) as GameObject;
			newBull.transform.Translate(0, 0, 0);
			shootTime = 0.2f;
		}
		
		//////////////Redirect////////////////
		if(gameObject.transform.position.x > 20)
		{
			Vector3 nieuwPos = transform.position;
			nieuwPos.x = -20;
			transform.position = nieuwPos;
		}
		if(gameObject.transform.position.x < -20)
		{
			Vector3 nieuwPos = transform.position;
			nieuwPos.x = 20;
			transform.position = nieuwPos;
		}
		if(gameObject.transform.position.z > 18)
		{
			Vector3 nieuwPos = transform.position;
			nieuwPos.z = -17;
			transform.position = nieuwPos;
		}
		if(gameObject.transform.position.z < -18)
		{
			Vector3 nieuwPos = transform.position;
			nieuwPos.z = 17;
			transform.position = nieuwPos;
		}
	}
	public void spawnAstroid()
	{
		astroidSpawnTimer = astroidSpawnTimer - Time.deltaTime;
		if(astroidSpawnTimer <= 0)
		{
			randomNumb1 = Random.Range(0, 4);
			randomNumb2 = Random.Range(0, 50);
			GameObject newAstroid = Instantiate(astroid, transform.position, Quaternion.identity) as GameObject;
			if(randomNumb1 == 0)
			{
				newAstroid.transform.Translate(-25, 0.5f, randomNumb2 * 0.15f);
			}
			if(randomNumb1 == 1)
			{
				newAstroid.transform.Translate(25, 0.5f, randomNumb2 * 0.15f);
			}
			if(randomNumb1 == 2)
			{
				newAstroid.transform.Translate(randomNumb2 * 0.2f, 0.5f, -25);
			}
			if(randomNumb1 == 3)
			{
				newAstroid.transform.Translate(randomNumb2 * 0.2f, 0.5f, 25);
			}
			newAstroid.transform.Translate(0, 0, 0);
			astroidSpawnTimer = 1;
		}
	}
	public void spawnEnemyShip()
	{
		enemyShipSpawnTimer = enemyShipSpawnTimer - Time.deltaTime;
		if(enemyShipSpawnTimer <= 0)
		{
			randomNumb1 = Random.Range(0, 4);
			randomNumb2 = Random.Range(0, 50);
			GameObject newEnemyShip = Instantiate(enemyShip, transform.position, Quaternion.identity) as GameObject;
			
			if(randomNumb1 == 0)
			{
				newEnemyShip.transform.Translate(-25, 0, randomNumb2 * 0.15f);
			}
			if(randomNumb1 == 1)
			{
				newEnemyShip.transform.Translate(25, 0, randomNumb2 * 0.15f);
			}
			if(randomNumb1 == 2)
			{
				newEnemyShip.transform.Translate(randomNumb2 * 0.2f, 0, -25);
			}
			if(randomNumb1 == 3)
			{
				newEnemyShip.transform.Translate(randomNumb2 * 0.2f, 0, 25);
			}
			newEnemyShip.transform.Translate(0, 0, 0);
			enemyShipSpawnTimer = 7.5f;
		}
	}
	public void OnTriggerEnter(Collider col)
	{	
		// destroy the enemy
		if(col.name == "Astriod(Clone)" || col.name == "LittleAstroid(Clone)" || col.name == "EnemyBullet(Clone)" || col.name == "Enemy(Clone)")
		{	
			Destroy(col.collider.gameObject);
			SetLifeText();
		}
	}
}
