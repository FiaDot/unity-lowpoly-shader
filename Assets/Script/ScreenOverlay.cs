using UnityEngine;
using System.Collections;
using UnityEngine.UI;

[ExecuteInEditMode]
public class ScreenOverlay : MonoBehaviour {
	#region Variables
	public Shader curShader;
	public float opacity = 0f;
	private Material curMaterial;
	#endregion

	public Text uiText = null;

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
			Debug.LogWarning ("!SystemInfo.supportsImageEffects");
			uiText.text = "!suppotImageEffeect";
			enabled = false;
			return;
		}

		if (!curShader) {
			Debug.LogWarning ("!curShader");
			uiText.text = "!curShader";
			enabled = false;
			return;
		}

		if (!curShader.isSupported) 
		{
			Debug.LogWarning ("!isSupported");
			uiText.text = "!isSupportedt";
			enabled = false;
			return;
		}

		uiText.text = "success";
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
