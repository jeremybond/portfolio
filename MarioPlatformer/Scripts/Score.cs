using UnityEngine;
using System.Collections;

public class Score : MonoBehaviour {
	
	//float teller;
	
	// Update is called once per frame
	void Update () {
		//teller += Time.deltaTime;
		guiText.text = "Score: " + Global.score.ToString();
		
	}
}
