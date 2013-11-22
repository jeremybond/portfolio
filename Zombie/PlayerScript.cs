using UnityEngine;
using System.Collections;

[RequireComponent(typeof(AudioSource))]
public class PlayerScript : MonoBehaviour {
	public Camera TopDownCam;
	public Camera ThirthPersCam;
	
	public float hitPoints;
	public float healup;
	public float lifecounter;
	
	public GameObject swordSlash;
	public AudioClip swoosh;
	public AudioClip gunshot;
	
	public Vector2 lastFrame;
	public Vector2 currentFrame;
	
	public Light ZakLamp;
	
	public float canthrowbomb;
	public float bombtimer;
	public bool bombtimerdown;
	GUIText hitpointsDisplay;
	GUITexture lifeBar;
	
	
	void Start()
	{
		bombtimerdown = false;
		bombtimer = 0;
		canthrowbomb = 0;
		lifecounter = 5;
		ThirthPersCam.enabled = false;
		currentFrame = Input.mousePosition;
		hitpointsDisplay = GameObject.Find("Hitpoints Display").GetComponent<GUIText>();
	}
	void OnGUI (){
		//GUI.Box(new Rect(20,20,hitPoints,20), "This is the title");
		//lifeBar.border.AddRect(new Rect(20,20,hitPoints,20), "This is the title");
		//GUI.Box(Rect(0,0,lifecounter,20),"This is a title");
	}
	
	void FixedUpdate () {
		if(hitPoints < 90)
		{
			
			lifecounter -= 1 * Time.deltaTime;
			
			if(lifecounter <= 0)
			{
				hitPoints += 2 * Time.deltaTime;
				
			}
		}
		if(hitPoints >= 90)lifecounter = 5;
		
		if(TopDownCam.enabled)
		{
			
			//RaycastHit mouseRaycastHit;
			
			
			//lastFrame = currentFrame;
			//currentFrame = Input.mousePosition;
			//Vector2 difference = lastFrame - currentFrame;
			
			Ray mouseHit = Camera.main.ScreenPointToRay(Input.mousePosition);
			RaycastHit[] allRaycastHits = Physics.RaycastAll(mouseHit);
			
			foreach(RaycastHit h in allRaycastHits)
			{
				if(h.collider.gameObject.name == "Vloer")
				{
					Vector3 pos = new Vector3(h.point.x, 0, h.point.z);
					//transform.Rotate(difference.y, difference.x, 0);
					transform.LookAt(pos);
				}
			}
			
		}
		if(ThirthPersCam.enabled)
		{
			transform.Rotate(0, Input.GetAxis("Horizontal"), 0);
			//transform.Rotate(Input.GetAxis("Vertical"), 0, 0);
		}
		
		//if(Physics.Raycast(mouseHit, out mouseRaycastHit, 1000))
		//{
			//Debug.Log(mouseRaycastHit.collider.gameObject.name);
		//	Vector3 pos = new Vector3(mouseRaycastHit.point.x, 0, mouseRaycastHit.point.z);
		//	
		//	transform.LookAt(pos);
		//}
		
		hitpointsDisplay.text = hitPoints.ToString("0");
		
		//Debug.DrawRay(transform.position, transform.TransformDirection(Vector3.forward) * 10, Color.green);
		rigidbody.velocity = Vector3.zero;
		if (Input.GetKey(KeyCode.W))
		{
			rigidbody.AddRelativeForce(0, 0, 550);
		}
		else if (Input.GetKey(KeyCode.S))
		{
			rigidbody.AddRelativeForce(0, 0, -500);
		}
		if (Input.GetKey(KeyCode.A))
		{
			rigidbody.AddRelativeForce(-500,0, 0);	
		}
		else if (Input.GetKey(KeyCode.D))
		{
			rigidbody.AddRelativeForce(500,0, 0);	
		}
		if(Input.GetKeyDown(KeyCode.F))
		{
			if(ZakLamp.enabled == false)ZakLamp.enabled = true;else ZakLamp.enabled = false;
		}
		if(Input.GetKeyDown(KeyCode.Tab))
		{
			if(TopDownCam.enabled == true)
			{
				Screen.lockCursor = true;
				TopDownCam.enabled = false;
				ThirthPersCam.enabled = true;
			}else{
				Screen.lockCursor = false;
				TopDownCam.enabled = true;
				ThirthPersCam.enabled = false;
			}
		}
		if (Input.GetKey(KeyCode.Z))
		{
			float number = Random.value;
			string zombieName = "";
			
			if(number > 0.2f)
			{
				zombieName = "Zombie";
			}
			else
			{
				zombieName = "Boomer";
			}

			GameObject newZombie = Instantiate(Resources.Load(zombieName), transform.position, Quaternion.identity) as GameObject;	
			newZombie.name = "Zombie";
			newZombie.transform.Rotate(0, Random.value * 360, 0);
			newZombie.transform.Translate(0, 0, 60);
		}
	
		
		if (Input.GetKeyDown(KeyCode.X))
		{
			AudioSource.PlayClipAtPoint(swoosh, transform.position, 5);
			Collider[] hitObjects = Physics.OverlapSphere(swordSlash.transform.position, 1);
			foreach (Collider hitObj in hitObjects)
			{
				if (hitObj.name == "Player" || hitObj.name == "Vloer")
				{
					continue;
				}else{
					hitObj.gameObject.GetComponent<ZombieScript>().TakeDamage(10, "sword Slash");
				}
				Instantiate(Resources.Load("Blood"), transform.position, Quaternion.identity);	
				
				
			}
		}
		
		
		if (Input.GetKey(KeyCode.Mouse0))
		{
			AudioSource.PlayClipAtPoint(gunshot, transform.position);
			Ray ray = new Ray(transform.position, transform.TransformDirection(Vector3.forward));
			Vector3 randomness = ray.direction;
			randomness.z += Random.value * 0.1f - 0.05f;
			randomness.y += Random.value * 0.1f - 0.05f;
			ray.direction = randomness;
			
			
			RaycastHit hit;
			Debug.DrawRay(ray.origin, ray.direction * 100, Color.green);	

			if (Physics.Raycast(ray, out hit, 100))
			{
				if (hit.collider.gameObject.name == "Zombie")
				{
					hit.collider.gameObject.GetComponent<ZombieScript>().TakeDamage(2, "");
				}
			}
		}
		GameObject.Find("Camera Follower").transform.position = transform.position;
		
		
		if(Input.GetKeyDown(KeyCode.C))
		{
			GameObject Bom = Instantiate(Resources.Load("C4"), transform.position, Quaternion.identity) as GameObject;
		    Bom.name = "C4";
		    Bom.transform.Translate(0,0,0);
		}
//		
	}
	public void OnTriggerEnter(Collider col)
	{
		
		if(col.name == "LifePack")
		{
			hitPoints += 10;
			Destroy(col.gameObject);
			Instantiate(Resources.Load("lifeSystem"), transform.position, Quaternion.identity);
		}
		if(col.name == "Bomb")
		{
			hitPoints -= 20;
			Destroy(col.gameObject);
			Instantiate(Resources.Load("BombSystem"), transform.position, Quaternion.identity);
			Instantiate(Resources.Load("BombSystem2"), transform.position, Quaternion.identity);
			Instantiate(Resources.Load("BombSystem3"), transform.position, Quaternion.identity);
		}
	}
	public void TakeDamage(float damage)
	{
		hitPoints -= damage;
		hitPoints += healup;
	}
}
