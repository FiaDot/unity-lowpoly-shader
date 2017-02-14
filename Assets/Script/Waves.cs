using UnityEngine;
using System.Collections;

// [ExecuteInEditMode]
public class Waves : MonoBehaviour {
	Vector3 waveSource1 = new Vector3 (2.0f, 0.0f, 2.0f);
	public float freq1 = 0.1f;
	public float amp1 = 0.01f;
	public float waveLength1 = 0.05f;
	Mesh mesh;
	Vector3[] vertices;

	// Use this for initialization
	void Start () {
		MeshFilter mf = GetComponent<MeshFilter>();
		if(mf == null)
		{
			Debug.Log("No mesh filter");
			return;
		}
		mesh = mf.sharedMesh;
		// mesh = mf.mesh;
		vertices = mesh.vertices;
	}

	// Update is called once per frame
	void Update () {
		CalcWave();
	}

	void CalcWave()
	{
		for(int i = 0; i < vertices.Length; i++)
		{
			Vector3 v = vertices[i];
			v.y = 0.0f;
			float dist = Vector3.Distance(v, waveSource1);
			dist = (dist % waveLength1) / waveLength1;
			v.y = amp1 * Mathf.Sin(Time.time * Mathf.PI * 2.0f * freq1
				+ (Mathf.PI * 2.0f * dist));
			vertices[i] = v;
		}
		mesh.RecalculateNormals (); 
		mesh.MarkDynamic ();


		mesh.vertices = vertices;

		GetComponent<MeshFilter> ().mesh = mesh;

		// GetComponent<MeshFilter> ().mesh = mesh;

	}
}
