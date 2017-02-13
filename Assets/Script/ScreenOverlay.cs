using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class ScreenOverlay : MonoBehaviour {
	#region Variables
	public Shader curShader;
	public float opacity = 0f;
	private Material curMaterial;
	#endregion

	#region Properties
	Material material
	{
		get
		{
			if(curMaterial == null)
			{
				curMaterial = new Material(curShader);
				curMaterial.hideFlags = HideFlags.HideAndDontSave;  
			}
			return curMaterial;
		}
	}
	#endregion


	void Start () 
	{
		if(!SystemInfo.supportsImageEffects)
		{
			enabled = false;
			return;
		}

		if (!curShader && !curShader.isSupported) 
		{
			enabled = false;
		}
	}

	void OnRenderImage (RenderTexture sourceTexture, RenderTexture destTexture)
	{
		if(curShader != null)
		{
			material.SetFloat("_Opacity", opacity);
			Graphics.Blit(sourceTexture, destTexture, material);
		}
		else
		{
			Graphics.Blit(sourceTexture, destTexture);  
		}


	}

	// Update is called once per frame
	void Update () 
	{
		opacity = Mathf.Clamp (opacity, 0.0f, 20.0f);
	}

	void OnDisable ()
	{
		if(curMaterial)
		{
			DestroyImmediate(curMaterial);  
		}

	}


}
