using UnityEngine;
using System.Collections;

public class IngameGui : MonoBehaviour {
	public GameObject highScore;
	public static int totalLifes = 3;
	public static int totalScore;
	void Awake(){
		int newFontSize = 1080 / Screen.width;
		newFontSize = 72 / newFontSize;
		gameObject.guiText.fontSize = newFontSize;
		Debug.Log("[InGameGUI] < R9 > I Start With " + totalLifes + " lives.");
	}
	public void UpdateScoreAndLives(){
		gameObject.guiText.text = "Lives: " + totalLifes + "   Score: " + totalScore;
	}
	void Update(){
		totalScore += 1;
		UpdateScoreAndLives();
	}

	public void LoseLife(){
		Debug.Log("[InGameGUI] < R20 > Just Lost A Life");
		totalLifes -= 1;
		UpdateScoreAndLives();
	}

	public void GetLife(){
		Debug.Log("[InGameGUI] < R26 > Just Found A Life");
		totalLifes += 1;
		UpdateScoreAndLives();
	}
	public void Lost(){
		Debug.Log("[InGameGUI] < R31 > I Just Died");
		//highScore.GetComponent<HighScoreScript>().Start();
		return;
	}
	public void ResetScoreAndLifes(){
		Debug.Log("[InGameGUI] < R35 > Reset");
		totalScore = 0;
	}
}
