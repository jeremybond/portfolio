using UnityEngine;
using System.Collections;

public class PlayerBehaviourScript : MonoBehaviour {

	public float speed;
	public GUIText countText;
	public GUIText winnText;
	private int count;
	private int maxCollectables;
	
	void Start(){
		GameObject[] collectables = GameObject.FindGameObjectsWithTag(TagsScript.Collectables);
		maxCollectables = collectables.Length;
		
		count = 0;
		SetWinningText();
		SetCountText();
	}
	// Update is called once per frame
	void FixedUpdate () {
		float horizontalMovement = Input.GetAxis("Horizontal");
		float verticalMovement = Input.GetAxis("Vertical");
		
		Vector3 movement = new Vector3(horizontalMovement, 0.0f, verticalMovement);
		
		rigidbody.AddForce(movement * speed * Time.deltaTime);
		if(transform.position.y < -10)
		{
			Application.LoadLevel(Application.loadedLevel);
		}
	}
	
	void OnTriggerEnter(Collider other)
	{
		if(other.tag == TagsScript.Collectables)
		{
			other.gameObject.SetActive(false);
			//Destroy(col.gameObject);
			count ++;
			
			SetCountText();
			SetWinningText();
		}
		if(other.tag == TagsScript.Finish)
		{
			if(count == maxCollectables)
			{
				var curLvl = Application.loadedLevel;
				Application.LoadLevel(curLvl + 1);
				countText.text = "0";
			}
		}
	}
	void SetWinningText()
	{
		if (count == maxCollectables)
		{
			winnText.text = "touch the black block";
		}else{
			winnText.text = "";
		}
	}
	void SetCountText()
	{
		countText.text = "Count: "+ count+"/"+maxCollectables;
	}
}
