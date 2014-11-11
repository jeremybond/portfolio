using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public enum ChunkSize
{
	Small = 0,
	Medium = 1,
	Large = 2
}
public class ObstacleListsAndSpawner : MonoBehaviour {
	//public GameObject[] allObst;
	public GameObject[] allObstacles;

	Dictionary<ChunkSize, Transform[]> map = new Dictionary<ChunkSize, Transform[] >();
	
	int listID;
	float waitingTime;

	void Start(){
		for (int p=0; p<allObstacles.Length; p++)
		{
			Transform[] obstacles = new Transform[allObstacles[p].transform.childCount];
			for (int i=0; i<obstacles.Length; i++)
			{
				obstacles[i] = allObstacles[p].transform.GetChild(i);
			}
			map.Add ((ChunkSize)p, obstacles);
		}
		StartCoroutine(ObstSpawner());
	}
	IEnumerator ObstSpawner(){
		int randomNumber = Random.Range(0,3);
		ChunkSize size = (ChunkSize)randomNumber;


		SpawnObject(size);


		if(size == ChunkSize.Small)waitingTime = 2f;
		else if(size == ChunkSize.Medium) waitingTime = 4.5f;
		else if(size == ChunkSize.Large) waitingTime = 6.5f;
		
		yield return new WaitForSeconds (waitingTime);
		StartCoroutine(ObstSpawner());
	}
	void SpawnObject(ChunkSize size)
	{
		Transform[] obstacles = map[size];
		int obstacleNr = Random.Range(0, obstacles.Length);

		Instantiate(obstacles[obstacleNr]);
	}






}