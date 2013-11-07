using UnityEngine;
using System.Collections;

public class BulletBehaviourScript : MonoBehaviour {
	public float timer;
	public GameObject enemyShip;
	public GameObject playerShip;
	// Use this for initialization
	void Start () {
		timer = 3;
		
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		timer -= 1 * Time.deltaTime;
		if(gameObject.name == "EnemyBullet(Clone)")
		{
			gameObject.transform.Translate(playerShip.transform.position);
		}else{
			transform.Translate(0, 0, 1);
		}
		if(timer<= 0)
		{
			Destroy(gameObject);
		}
		
	}
}
