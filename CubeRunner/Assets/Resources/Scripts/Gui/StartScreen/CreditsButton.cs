using UnityEngine;
using System.Collections;

public class CreditsButton : MonoBehaviour {
	public Texture2D button1;
	public Texture2D button2;
	void Start(){
		guiTexture.texture = button1;
	}
	/*
	void OnMouseDown(){
		guiTexture.texture = button2;
	}
	void OnMouseUp(){
		guiTexture.texture = button1;
		Application.LoadLevel(3);
	}*/
	void Update (){
		foreach (Touch touch in Input.touches)
		{
			if (guiTexture.HitTest(touch.position) && touch.phase != TouchPhase.Ended)
			{
				guiTexture.texture = button2;
			}
			else if (guiTexture.HitTest(touch.position) && touch.phase == TouchPhase.Ended)
			{
				guiTexture.texture = button1;
				Application.LoadLevel(3);
			}else if(!guiTexture.HitTest(touch.position))
			{
				guiTexture.texture = button1;
			}
		}
	}
}
