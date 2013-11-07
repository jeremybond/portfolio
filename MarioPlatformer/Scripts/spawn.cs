using UnityEngine;
using System.Collections;

public class spawn : MonoBehaviour {
	public float spawntimer;
	
	// Use this for initialization
	void Start () {
		spawntimer = 2f;
	}
	
	// Update is called once per frame
	void Update () {
		if(spawntimer > 0)
		{
			spawntimer -= Time.deltaTime;
			if(spawntimer < 0)
			{
				//Debug.Log ("spawn");
				GameObject newObject3 = Instantiate(Resources.Load("Enemy 1"), transform.position, Quaternion.identity) as GameObject;
				newObject3.transform.Translate(0, 0, 0.4f);
				spawntimer = 1f;
			}
		}
	}
}
