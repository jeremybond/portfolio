using UnityEngine;
using System.Collections;

public class HighScoreScript : MonoBehaviour {
	public GameObject ingameGui;
	public void Start(){
		CheckNewHighScore();
	}
	public void CheckNewHighScore(){
		int score = IngameGui.totalScore;
		int highScore = PlayerPrefs.GetInt("PersonalHighScore", 0);
		if(score > highScore)
		{
			PlayerPrefs.SetInt("PersonalHighScore", score);
			PlayerPrefs.Save ();
		}
		int newFontSize = 1080 / Screen.width;
		newFontSize = 72 / newFontSize;
		gameObject.guiText.fontSize = newFontSize;
		gameObject.guiText.text = "HighScore\n" + (PlayerPrefs.GetInt("PersonalHighScore", 0)) + "\n\n" + "Score\n" + score;

		ingameGui.GetComponent<IngameGui>().ResetScoreAndLifes();
	}
}