using UnityEngine;
using System.Collections;

public class PlayerCollision : MonoBehaviour {
	public GameObject inGameGui;
	private int lives;
	void OnCollisionEnter(Collision col)
	{
		Destroy(col.gameObject);
		if(col.collider.name == "Cube"){
			if(IngameGui.totalLifes > 0)
				inGameGui.GetComponent<IngameGui>().LoseLife();

			if(IngameGui.totalLifes == 0){
				IngameGui.totalLifes += 3;
				Application.LoadLevel(2);
			}
		}//else if(col.collider.name == "ExtraLife")
			//inGameGui.GetComponent<IngameGui>().GetLife();
	}
}
