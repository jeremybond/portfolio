using UnityEngine;
using System.Collections;

public class AstroidsBehaviourScript : MonoBehaviour {
	private int randomNumb;
	public int score;
	public GameObject miniAstroid;
	public GameObject enemyBullet;
	public float enemyShootTimer;
	public float miniEnemySpawnTimer;
	
	
	void Start () {
		miniEnemySpawnTimer = 0;
		score=0;
		enemyShootTimer = 1;
		randomNumb = GameObject.FindGameObjectWithTag("Player").GetComponent<PlayerBehaviourScript>().randomNumb1;
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		miniEnemySpawnTimer -= Time.deltaTime;
		enemyShootTimer -= Time.deltaTime;
		if(gameObject.name == "Enemy(Clone)")
		{
			if(enemyShootTimer <= 0)
			{
				GameObject newEnemyBull = Instantiate(enemyBullet, transform.position, transform.rotation) as GameObject;
				newEnemyBull.transform.Translate(0, 0, 0);
				enemyShootTimer = 1;
			}
		}
		if(randomNumb == 0)
		{
			transform.Translate(0.2f, 0, 0);
			if(transform.position.x > 35)
			{
				Destroy(gameObject);
			}
		}
		if(randomNumb == 1)
		{
			transform.Translate(-0.2f, 0, 0);
			if(transform.position.x < -35)
			{
				Destroy(gameObject);
			}
		}
		if(randomNumb == 2)
		{
			transform.Translate(0, 0, 0.2f);
			if(transform.position.z > 35)
			{
				Destroy(gameObject);
			}
		}
		if(randomNumb == 3)
		{
			transform.Translate(0, 0, -0.2f);
			if(transform.position.z < -35)
			{
				Destroy(gameObject);
			}
		}
	}
	void OnTriggerEnter(Collider col)
	{	
		// destroy the enemy && destroy the bullet
		if(col.name == "Bullet" || col.name == "Bullet(Clone)")
		{	
			
			Destroy(col.collider.gameObject);
			Destroy(gameObject);
			GameObject.FindGameObjectWithTag("Player").GetComponent<PlayerBehaviourScript>().SetCountText();
			if(miniEnemySpawnTimer <= 0)
			{
				if(this.name == "Astriod(Clone)")
				{
					GameObject newMiniAstroid1 = Instantiate(miniAstroid, gameObject.transform.position, gameObject.transform.rotation) as GameObject;
					newMiniAstroid1.transform.Translate(1, 0, 1);
					newMiniAstroid1.transform.Rotate(0, 45, 0);
					GameObject newMiniAstroid2 = Instantiate(miniAstroid, gameObject.transform.position, gameObject.transform.rotation) as GameObject;
					newMiniAstroid2.transform.Translate(1, 0, 1);
					newMiniAstroid2.transform.Rotate(0, -45, 0);
				}
				miniEnemySpawnTimer = 1;
			}
		}
			
	}
	
}
