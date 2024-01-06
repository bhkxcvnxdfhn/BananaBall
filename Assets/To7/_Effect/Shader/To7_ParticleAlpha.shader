// Made with Amplify Shader Editor v1.9.2.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "To7/ParticleAlpha"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Header(MainTex)][Space(10)]_MainTex("MainTex", 2D) = "white" {}
		_MainTexST("MainTex ST", Vector) = (1,1,0,0)
		[HDR]_MainColor("MainColor", Color) = (1,1,1,1)
		[KeywordEnum(OnlyST,FlowbyTime,CustomDataXY)] _MainTexSTPattern("MainTex ST Pattern", Float) = 0
		[KeywordEnum(RGB,R,G,B,A)] _MainTexChannel("MainTex Channel", Float) = 0
		[Header(Mask)][NoScaleOffset][SingleLineTexture][Space(10)]_MaskTexture("Mask Texture", 2D) = "white" {}
		_MaskTexST("MaskTex ST", Vector) = (1,1,0,0)
		[KeywordEnum(OnlyST,FlowbyTime,CustomDataXY)] _MaskTexSTPattern("MaskTex ST Pattern", Float) = 0
		[KeywordEnum(R,G,B,A)] _MaskChannel("Mask Channel", Float) = 0
		[Toggle(_MASKAFFECTALPHA_ON)] _MaskAffectAlpha("Mask Affect Alpha ?", Float) = 1
		_MaskPower("Mask Power", Float) = 1
		_MaskMultiply("Mask Multiply", Float) = 1
		[KeywordEnum(Disable,Const,CustomData2Z)] _MaskUseFrom1to0Dissolve("Mask Use From 1 to 0 Dissolve", Float) = 0
		_MaskAdd("Mask Add", Float) = 0
		[Header(Distort)][NoScaleOffset][SingleLineTexture][Space(10)]_DistortTexture("Distort Texture", 2D) = "white" {}
		_DistortTexST("DistortTex ST", Vector) = (1,1,0,0)
		[KeywordEnum(OnlyST,FlowbyTime,CustomWT)] _DistortTexSTPattern("DistortTex ST Pattern", Float) = 0
		_DistortStrength("Distort Strength", Float) = 0
		[KeywordEnum(R,G,B,A)] _DistortChannel("Distort Channel", Float) = 0
		[Header(Alpha Setting)][Space(5)][KeywordEnum(R,G,B,A)] _AlphaChannel("Alpha Channel", Float) = 3
		_FinalAlphaDeepen("Final Alpha Deepen", Float) = 1
		[Header(Alpha Step)][Space(5)][Toggle(_ALPHAUSESTEP_ON)] _AlphaUseStep("Alpha Use Step", Float) = 0
		[KeywordEnum(Step,Smoothstep)] _StepOption("Step Option", Float) = 0
		_Step("Step", Range( 0 , 1)) = 0
		_Softness("Softness", Range( 0 , 1)) = 0
		[Header(Depth Fade)][Space(5)][Toggle(_USEDEPTHFADE_ON)] _UseDepthFade("Use Depth Fade", Float) = 0
		_DepthFade("DepthFade", Float) = 0
		[Header(CameraFade Setting)][Toggle(_USECAMERADEPTH_ON)] _UseCameraDepth("Use Camera Depth", Float) = 0
		_CameraFadeLength("Camera Fade Length", Range( 0.5 , 5)) = 1
		_CameraFadeOffset("Camera Fade Offset", Float) = 0
		[Header(Vertex Offset Setting)][Space(5)][Toggle(_USEVERTEXOFFSET_ON)] _UseVertexOffset("Use Vertex Offset", Float) = 0
		[NoScaleOffset][SingleLineTexture]_OffsetTexture("Offset Texture", 2D) = "black" {}
		_OffsetTex_ST("OffsetTex_ST", Vector) = (1,1,0,0)
		_AxisStrength("Axis Strength", Vector) = (0,0,0,0)
		[Header(Flipbook Setting)][Space(5)][Toggle(_USEFLIPBOOK_ON)] _UseFlipbook("Use Flipbook", Float) = 0
		[KeywordEnum(Constant,Speed)] _FlipbookMode("Flipbook Mode", Float) = 0
		_FlipbookColumnsRowsSpeedStartFrame("Flipbook Columns / Rows / Speed / StartFrame", Vector) = (4,4,9,0)
		[Header(Fresnel Setting)][Space(10)][Toggle(_IMPACTCOLOR_ON)] _ImpactColor("Impact Color", Float) = 0
		[Toggle(_IMPACTALPHA_ON)] _ImpactAlpha("Impact Alpha", Float) = 0
		[HDR]_FresnelColor("Fresnel Color", Color) = (1,1,1,1)
		_FresnelScale("Fresnel Scale", Float) = 1
		_FresnelPower("Fresnel Power", Float) = 5
		[Toggle(_INVERSERANGE_ON)] _InverseRange("Inverse Range", Float) = 0
		[Header(External Alpha Templete)][KeywordEnum(Disable,Line,Gradient)] _ExternalAlphaOption("External Alpha Option", Float) = 0
		[KeywordEnum(Vertical,Horizontal)] _Direction("Direction", Float) = 1
		[KeywordEnum(Const,CustomData2w)] _ControlMethod("Control Method", Float) = 0
		[Toggle(_INVERSEEXTERNELALPHARANGE_ON)] _InverseExternelAlphaRange("Inverse Externel Alpha Range", Float) = 0
		_ExternelAlphaValue("Externel Alpha Value", Float) = 0
		_ExternelAlphaRangePower("Externel Alpha Range Power", Float) = 1
		_ExternelAlphaRangeMultiply("Externel Alpha Range Multiply", Float) = 1
		[Toggle(_EXTERNELALPHACHECKER_ON)] _ExternelAlphaChecker("Externel Alpha Checker", Float) = 0
		[Header(Color Ramp Setting)][Space(10)][Toggle(_USECOLORRAMP_ON)] _UseColorRamp("Use Color Ramp", Float) = 0
		_ColorRamp("Color Ramp", 2D) = "white" {}
		_ColorRampEmission("Color Ramp Emission", Float) = 1
		_GrayScaleOffset("GrayScale Offset", Range( 0 , 1)) = 0
		[Toggle(_RAMPMULTIPLYVERTEXCOLOR_ON)] _RampMultiplyVertexColor("Ramp Multiply Vertex Color", Float) = 0
		[Header(Open Double Face Setting)][Toggle(_DOUBLEFACECOLOR_ON)] _DoubleFaceColor("Double Face Color", Float) = 0
		[HDR]_FrontColor("FrontColor", Color) = (1,1,1,1)
		[HDR]_BackColor("BackColor", Color) = (1,1,1,1)
		[Header(Light Setting)][Space(10)][Toggle(_USELIGHT_ON)] _UseLight("Use Light", Float) = 0
		_LightStrength("Light Strength", Float) = 1
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalStrength("Normal Strength", Float) = 1
		[Header(Flow Noise)][Space(10)][KeywordEnum(Disable,Simplex2D,Gradient,Simple)] _FlowNoise("FlowNoise", Float) = 0
		_NoiseStrength("Noise Strength", Float) = 1
		_NoiseUV("NoiseUV", Vector) = (3,3,0,0)
		[Header(Parallax Setting,CustomVertex Streams Need TANGENT)][Space(10)][Toggle(_USEPARALLAX_ON)] _UseParallax("Use Parallax", Float) = 0
		_HeightMap1("HeightMap", 2D) = "white" {}
		_HeightMap_ST("HeightMap_ST", Vector) = (1,1,0,0)
		_HeightMapNoise("HeightMapNoise", 2D) = "white" {}
		_HeightMapNoise_ST("HeightMapNoise_ST", Vector) = (1,1,0,0)
		[KeywordEnum(Const,CustomData2X)] _ParallaxStrengthControlMethod("Parallax Strength Control Method", Float) = 0
		_ParallaxStrength("Parallax Strength", Float) = 0
		_SampleSteps("SampleSteps", Float) = 0
		[Header(Other Setting)][Enum(UnityEngine.Rendering.CullMode)][Space(5)]_CullMode("Cull Mode", Float) = 2
		[Enum(Additive,1,Alpha,10)]_BlendMode("Blend Mode", Float) = 10
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestSetting("ZTest Setting", Float) = 4
		[Enum(Off,0,On,1)]_ZWriteSet("ZWrite Set", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" }
		
		Cull [_CullMode]
		AlphaToMask Off
		
		HLSLINCLUDE
		#pragma target 5.0

		#pragma prefer_hlslcc gles
		

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend SrcAlpha [_BlendMode], One OneMinusSrcAlpha
			ZWrite [_ZWriteSet]
			ZTest [_ZTestSetting]
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			
			#pragma multi_compile_instancing
			#define _RECEIVE_SHADOWS_OFF 1
			#define ASE_SRP_VERSION -1
			#define REQUIRE_DEPTH_TEXTURE 1
			#define ASE_USING_SAMPLING_MACROS 1

			
			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#if ASE_SRP_VERSION <= 70108
			#define REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
			#endif

			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_SHADOWCOORDS
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _EXTERNELALPHACHECKER_ON
			#pragma shader_feature_local _RAMPMULTIPLYVERTEXCOLOR_ON
			#pragma shader_feature_local _USECOLORRAMP_ON
			#pragma shader_feature_local _IMPACTCOLOR_ON
			#pragma shader_feature_local _INVERSERANGE_ON
			#pragma shader_feature_local _USELIGHT_ON
			#pragma shader_feature_local _MAINTEXCHANNEL_RGB _MAINTEXCHANNEL_R _MAINTEXCHANNEL_G _MAINTEXCHANNEL_B _MAINTEXCHANNEL_A
			#pragma shader_feature_local _USEPARALLAX_ON
			#pragma shader_feature_local _USEFLIPBOOK_ON
			#pragma shader_feature_local _MAINTEXSTPATTERN_ONLYST _MAINTEXSTPATTERN_FLOWBYTIME _MAINTEXSTPATTERN_CUSTOMDATAXY
			#pragma shader_feature_local _DISTORTCHANNEL_R _DISTORTCHANNEL_G _DISTORTCHANNEL_B _DISTORTCHANNEL_A
			#pragma shader_feature_local _DISTORTTEXSTPATTERN_ONLYST _DISTORTTEXSTPATTERN_FLOWBYTIME _DISTORTTEXSTPATTERN_CUSTOMWT
			#pragma shader_feature_local _PARALLAXSTRENGTHCONTROLMETHOD_CONST _PARALLAXSTRENGTHCONTROLMETHOD_CUSTOMDATA2X
			#pragma shader_feature_local _FLIPBOOKMODE_CONSTANT _FLIPBOOKMODE_SPEED
			#pragma shader_feature_local _FLOWNOISE_DISABLE _FLOWNOISE_SIMPLEX2D _FLOWNOISE_GRADIENT _FLOWNOISE_SIMPLE
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _SHADOWS_SOFT
			#pragma shader_feature_local _MASKUSEFROM1TO0DISSOLVE_DISABLE _MASKUSEFROM1TO0DISSOLVE_CONST _MASKUSEFROM1TO0DISSOLVE_CUSTOMDATA2Z
			#pragma shader_feature_local _MASKCHANNEL_R _MASKCHANNEL_G _MASKCHANNEL_B _MASKCHANNEL_A
			#pragma shader_feature_local _MASKTEXSTPATTERN_ONLYST _MASKTEXSTPATTERN_FLOWBYTIME _MASKTEXSTPATTERN_CUSTOMDATAXY
			#pragma shader_feature_local _DOUBLEFACECOLOR_ON
			#pragma shader_feature_local _ALPHAUSESTEP_ON
			#pragma shader_feature_local _EXTERNALALPHAOPTION_DISABLE _EXTERNALALPHAOPTION_LINE _EXTERNALALPHAOPTION_GRADIENT
			#pragma shader_feature_local _DIRECTION_VERTICAL _DIRECTION_HORIZONTAL
			#pragma shader_feature_local _INVERSEEXTERNELALPHARANGE_ON
			#pragma shader_feature_local _CONTROLMETHOD_CONST _CONTROLMETHOD_CUSTOMDATA2W
			#pragma shader_feature_local _IMPACTALPHA_ON
			#pragma shader_feature_local _ALPHACHANNEL_R _ALPHACHANNEL_G _ALPHACHANNEL_B _ALPHACHANNEL_A
			#pragma shader_feature_local _MASKAFFECTALPHA_ON
			#pragma shader_feature_local _USEDEPTHFADE_ON
			#pragma shader_feature_local _USECAMERADEPTH_ON
			#pragma shader_feature_local _STEPOPTION_STEP _STEPOPTION_SMOOTHSTEP
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile _ _FORWARD_PLUS


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				half4 ase_tangent : TANGENT;
				float4 ase_texcoord2 : TEXCOORD2;
				half4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef ASE_FOG
				float fogFactor : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_color : COLOR;
				float4 ase_texcoord10 : TEXCOORD10;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _FrontColor;
			half4 _HeightMap1_ST;
			half4 _BackColor;
			half4 _OffsetTex_ST;
			half4 _MainColor;
			half4 _FresnelColor;
			half4 _NoiseUV;
			half4 _MainTexST;
			half4 _DistortTexST;
			half4 _MaskTexST;
			half4 _FlipbookColumnsRowsSpeedStartFrame;
			half4 _HeightMapNoise_ST;
			half4 _HeightMap_ST;
			half3 _AxisStrength;
			half _BlendMode;
			half _ColorRampEmission;
			half _ExternelAlphaRangeMultiply;
			half _ExternelAlphaRangePower;
			half _DepthFade;
			half _FinalAlphaDeepen;
			half _CameraFadeLength;
			half _CameraFadeOffset;
			half _Step;
			half _ExternelAlphaValue;
			half _MaskAdd;
			half _NoiseStrength;
			half _MaskPower;
			half _LightStrength;
			half _NormalStrength;
			half _Softness;
			half _ParallaxStrength;
			half _SampleSteps;
			half _DistortStrength;
			half _FresnelPower;
			half _FresnelScale;
			half _ZWriteSet;
			half _CullMode;
			half _ZTestSetting;
			half _MaskMultiply;
			half _GrayScaleOffset;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			TEXTURE2D(_OffsetTexture);
			SAMPLER(sampler_OffsetTexture);
			TEXTURE2D(_MainTex);
			TEXTURE2D(_DistortTexture);
			SAMPLER(sampler_DistortTexture);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_HeightMap1);
			TEXTURE2D(_HeightMapNoise);
			SAMPLER(sampler_Linear_Repeat);
			TEXTURE2D(_NormalMap);
			SAMPLER(sampler_NormalMap);
			SAMPLER(sampler_HeightMap1);
			TEXTURE2D(_MaskTexture);
			SAMPLER(sampler_MaskTexture);
			TEXTURE2D(_ColorRamp);
			uniform float4 _CameraDepthTexture_TexelSize;
			SAMPLER(sampler_Linear_Clamp);


			half2 Parallax536( TEXTURE2D(_HeightMap), TEXTURE2D(_HeightMapNoise), SamplerState linear_repeat_sampler, half _HeightSampleSteps, half3 ViewDir, half4 customData2, half4 pos, int _HeightMapNoiseChannel, inout half2 uv, half4 _HeightMap_ST, half4 _HeightMapNoise_ST, half2 MainTexUV, half4 _MainTex_ST )
			{
				half HeightValue = SAMPLE_TEXTURE2D(_HeightMap, linear_repeat_sampler, TRANSFORM_TEX(uv.xy, _HeightMap)).r;
												//half HeightValue = tex2D(_HeightMap , TRANSFORM_TEX(uv.xy, _HeightMap));
												                    //const int minLayers = 32;
												                    //const int maxLayers = 64;
												                    //float viewDirOptimize = max(abs(dot(float3(0,0,1),normalize(o.ViewDir))),0) * maxLayers;
												                    float numLayers = _HeightSampleSteps;
												                    float layerDepth = 1 / numLayers;
												                    float currentLayerDepth = 0;
												                    float2 P = ViewDir.xy * customData2.z / pos.w; //(opration: pos.w可以減少因鏡頭距離太遠而產生過高的偏移)
												                    float2 deltaTexCoords = P / numLayers;
												                    float2 currentTexCoords = uv.xy;
												                    float currentDepthMapValue = HeightValue;
												                    half HeightMapNoise = SAMPLE_TEXTURE2D(_HeightMapNoise, linear_repeat_sampler, TRANSFORM_TEX(uv.xy , _HeightMapNoise))[
												                        _HeightMapNoiseChannel];
																	//half HeightMapNoise = tex2D(_HeightMapNoise, TRANSFORM_TEX(uv.xy , _HeightMapNoise)).r;	
												                    [loop]
												                    while (currentLayerDepth < currentDepthMapValue) {
												                        currentTexCoords -= deltaTexCoords * HeightMapNoise;
												                        currentDepthMapValue = SAMPLE_TEXTURE2D_LOD(_HeightMap, linear_repeat_sampler, TRANSFORM_TEX(currentTexCoords, _HeightMap), 0).r;
																		//currentDepthMapValue = tex2Dlod(_HeightMap , float4(TRANSFORM_TEX(currentTexCoords, _HeightMap) , 0 , 0)).r;
												                        currentLayerDepth += layerDepth;
												                    }
												                    /*註記:由於下面的計算方式類似RayMarching的遞進式，且會拿當前的值與HeightMap值做對比再決定是否繼續往下跑，因此Unroll(一次性展開所有計算方式)並不划算。
												                    GPU的if-statement並不會跳過fail情況的計算，而是先進行計算在取決於當前條件是否成功。因此根據當前情況進行loop跳轉會比較合適。
												                    [unroll(32)]
												                    while(currentLayerDepth<currentDepthMapValue){
												                        currentTexCoords -= deltaTexCoords;
												                        currentDepthMapValue = tex2D(_HeightMap,currentTexCoords).r;
												                        currentLayerDepth += layerDepth;
												                    }
												註記:如果不使用Unroll則會報錯,主要原因為tex2D並不能在loop標籤下執行。因為GPU是以每四個像素一次進行著色，而fragment需要透過像素之間的UV差距來判斷
												要使用的mipmaps。而動態分支對於不同的像素計算方式無法確定，所以禁止使用tex2D。
												但可以透過tex2Dlod或tex2DGrad直接指定mipmap等級，否則就需要宣告unroll標籤。*/
												                    float2 preTexCoords = currentTexCoords + deltaTexCoords;
												                    float beforeDepth = SAMPLE_TEXTURE2D(_HeightMap, linear_repeat_sampler, TRANSFORM_TEX(preTexCoords,_HeightMap)).r - currentLayerDepth + layerDepth;
																	//float beforeDepth = tex2D(_HeightMap , TRANSFORM_TEX(preTexCoords,_HeightMap)).r - currentLayerDepth + layerDepth;
												                    float afterDepth = currentDepthMapValue - currentLayerDepth;
												                    float weight = afterDepth / (afterDepth - beforeDepth);
												                    float2 finalTexCoords = preTexCoords * weight + currentTexCoords * (1 - weight);
												                    //if( finalTexCoords.x>1 || finalTexCoords.y>1 || finalTexCoords.x<0 || finalTexCoords.y<0 )
												                    //   discard;
												                    MainTexUV = TRANSFORM_TEX(finalTexCoords, _MainTex);
												                    uv.xy = finalTexCoords;
												return MainTexUV;
			}
			
			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			
			//https://www.shadertoy.com/view/XdXGW8
			float2 GradientNoiseDir( float2 x )
			{
				const float2 k = float2( 0.3183099, 0.3678794 );
				x = x * k + k.yx;
				return -1.0 + 2.0 * frac( 16.0 * k * frac( x.x * x.y * ( x.x + x.y ) ) );
			}
			
			float GradientNoise( float2 UV, float Scale )
			{
				float2 p = UV * Scale;
				float2 i = floor( p );
				float2 f = frac( p );
				float2 u = f * f * ( 3.0 - 2.0 * f );
				return lerp( lerp( dot( GradientNoiseDir( i + float2( 0.0, 0.0 ) ), f - float2( 0.0, 0.0 ) ),
						dot( GradientNoiseDir( i + float2( 1.0, 0.0 ) ), f - float2( 1.0, 0.0 ) ), u.x ),
						lerp( dot( GradientNoiseDir( i + float2( 0.0, 1.0 ) ), f - float2( 0.0, 1.0 ) ),
						dot( GradientNoiseDir( i + float2( 1.0, 1.0 ) ), f - float2( 1.0, 1.0 ) ), u.x ), u.y );
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			half3 PerturbNormal107_g15( half3 surf_pos, half3 surf_norm, half height, half scale )
			{
				// "Bump Mapping Unparametrized Surfaces on the GPU" by Morten S. Mikkelsen
				float3 vSigmaS = ddx( surf_pos );
				float3 vSigmaT = ddy( surf_pos );
				float3 vN = surf_norm;
				float3 vR1 = cross( vSigmaT , vN );
				float3 vR2 = cross( vN , vSigmaS );
				float fDet = dot( vSigmaS , vR1 );
				float dBs = ddx( height );
				float dBt = ddy( height );
				float3 vSurfGrad = scale * 0.05 * sign( fDet ) * ( dBs * vR1 + dBt * vR2 );
				return normalize ( abs( fDet ) * vN - vSurfGrad );
			}
			
			half3 AdditionalLightsFlat10x( float3 WorldPosition )
			{
				float3 Color = 0;
				#ifdef _ADDITIONAL_LIGHTS
					uint lightCount = GetAdditionalLightsCount();
					for (uint lightIndex = 0u; lightIndex < lightCount; ++lightIndex)
					{
						Light light = GetAdditionalLight(lightIndex, WorldPosition);
						Color += light.color *(light.distanceAttenuation * light.shadowAttenuation);	
					}
				#endif
				return Color;
			}
			
			
			VertexOutput VertexFunction ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				half2 appendResult186 = (half2(_OffsetTex_ST.z , _OffsetTex_ST.w));
				half2 appendResult185 = (half2(_OffsetTex_ST.x , _OffsetTex_ST.y));
				half2 texCoord176 = v.ase_texcoord * appendResult185 + float2( 0,0 );
				half2 panner181 = ( 1.0 * _Time.y * appendResult186 + texCoord176);
				#ifdef _USEVERTEXOFFSET_ON
				half3 staticSwitch108 = ( ( (-0.5 + (SAMPLE_TEXTURE2D_LOD( _OffsetTexture, sampler_OffsetTexture, panner181, 0.0 ).r - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) * _AxisStrength ) + float3( 0,0,0 ) );
				#else
				half3 staticSwitch108 = float3( 0,0,0 );
				#endif
				half3 Vertex_Offset_Output290 = staticSwitch108;
				
				half3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				half3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord6.xyz = ase_worldTangent;
				half ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord7.xyz = ase_worldBitangent;
				float4 ase_clipPos = TransformObjectToHClip((v.vertex).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord10 = screenPos;
				half3 customSurfaceDepth91 = v.vertex.xyz;
				half customEye91 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth91)).z;
				o.ase_texcoord3.w = customEye91;
				
				o.ase_texcoord4 = v.ase_texcoord;
				o.ase_texcoord5 = v.ase_texcoord1;
				o.ase_texcoord8 = v.vertex;
				o.ase_texcoord9.xy = v.ase_texcoord2.xy;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord6.w = 0;
				o.ase_texcoord7.w = 0;
				o.ase_texcoord9.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Vertex_Offset_Output290;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				#ifdef ASE_FOG
				o.fogFactor = ComputeFogFactor( positionCS.z );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				half4 ase_tangent : TANGENT;
				float4 ase_texcoord2 : TEXCOORD2;
				half4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_tangent = v.ase_tangent;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN , bool ase_vface : SV_IsFrontFace ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				half3 ase_worldNormal = IN.ase_texcoord3.xyz;
				half fresnelNdotV217 = dot( ase_worldNormal, ase_worldViewDir );
				half fresnelNode217 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV217, _FresnelPower ) );
				half temp_output_225_0 = saturate( abs( fresnelNode217 ) );
				#ifdef _INVERSERANGE_ON
				half staticSwitch226 = ( 1.0 - temp_output_225_0 );
				#else
				half staticSwitch226 = temp_output_225_0;
				#endif
				half Fresnel223 = staticSwitch226;
				half4 lerpResult222 = lerp( _MainColor , _FresnelColor , Fresnel223);
				#ifdef _IMPACTCOLOR_ON
				half4 staticSwitch218 = lerpResult222;
				#else
				half4 staticSwitch218 = _MainColor;
				#endif
				half2 appendResult18 = (half2(_MainTexST.x , _MainTexST.y));
				half2 appendResult19 = (half2(_MainTexST.z , _MainTexST.w));
				half4 appendResult23 = (half4(appendResult18 , ( appendResult19 * _TimeParameters.x )));
				half4 texCoord12 = IN.ase_texcoord4;
				texCoord12.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				half2 appendResult24 = (half2(texCoord12.z , texCoord12.w));
				half4 appendResult25 = (half4(appendResult18 , appendResult24));
				#if defined(_MAINTEXSTPATTERN_ONLYST)
				half4 staticSwitch15 = _MainTexST;
				#elif defined(_MAINTEXSTPATTERN_FLOWBYTIME)
				half4 staticSwitch15 = appendResult23;
				#elif defined(_MAINTEXSTPATTERN_CUSTOMDATAXY)
				half4 staticSwitch15 = appendResult25;
				#else
				half4 staticSwitch15 = _MainTexST;
				#endif
				half4 break28 = staticSwitch15;
				half2 appendResult29 = (half2(break28.x , break28.y));
				half2 appendResult31 = (half2(break28.z , break28.w));
				half2 texCoord11 = IN.ase_texcoord4.xy * appendResult29 + appendResult31;
				half2 appendResult69 = (half2(_DistortTexST.x , _DistortTexST.y));
				half2 appendResult73 = (half2(_DistortTexST.z , _DistortTexST.w));
				half4 appendResult71 = (half4(appendResult69 , ( appendResult73 * _TimeParameters.x )));
				half2 appendResult207 = (half2(_DistortTexST.x , _DistortTexST.y));
				half4 texCoord205 = IN.ase_texcoord5;
				texCoord205.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				half2 appendResult208 = (half2(texCoord205.z , texCoord205.w));
				half4 appendResult206 = (half4(appendResult207 , appendResult208));
				#if defined(_PARALLAXSTRENGTHCONTROLMETHOD_CONST)
				half4 staticSwitch549 = appendResult206;
				#elif defined(_PARALLAXSTRENGTHCONTROLMETHOD_CUSTOMDATA2X)
				half4 staticSwitch549 = _DistortTexST;
				#else
				half4 staticSwitch549 = appendResult206;
				#endif
				#if defined(_DISTORTTEXSTPATTERN_ONLYST)
				half4 staticSwitch74 = _DistortTexST;
				#elif defined(_DISTORTTEXSTPATTERN_FLOWBYTIME)
				half4 staticSwitch74 = appendResult71;
				#elif defined(_DISTORTTEXSTPATTERN_CUSTOMWT)
				half4 staticSwitch74 = staticSwitch549;
				#else
				half4 staticSwitch74 = _DistortTexST;
				#endif
				half4 break66 = staticSwitch74;
				half2 appendResult68 = (half2(break66.x , break66.y));
				half2 appendResult67 = (half2(break66.z , break66.w));
				half2 texCoord65 = IN.ase_texcoord4.xy * appendResult68 + appendResult67;
				half4 tex2DNode64 = SAMPLE_TEXTURE2D( _DistortTexture, sampler_DistortTexture, texCoord65 );
				#if defined(_DISTORTCHANNEL_R)
				half staticSwitch81 = tex2DNode64.r;
				#elif defined(_DISTORTCHANNEL_G)
				half staticSwitch81 = tex2DNode64.g;
				#elif defined(_DISTORTCHANNEL_B)
				half staticSwitch81 = tex2DNode64.b;
				#elif defined(_DISTORTCHANNEL_A)
				half staticSwitch81 = tex2DNode64.a;
				#else
				half staticSwitch81 = tex2DNode64.r;
				#endif
				half DistortOutput84 = ( staticSwitch81 * _DistortStrength );
				half2 temp_output_85_0 = ( texCoord11 + DistortOutput84 );
				#if defined(_FLIPBOOKMODE_CONSTANT)
				half staticSwitch202 = ( _FlipbookColumnsRowsSpeedStartFrame.z / _TimeParameters.x );
				#elif defined(_FLIPBOOKMODE_SPEED)
				half staticSwitch202 = _FlipbookColumnsRowsSpeedStartFrame.z;
				#else
				half staticSwitch202 = ( _FlipbookColumnsRowsSpeedStartFrame.z / _TimeParameters.x );
				#endif
				// *** BEGIN Flipbook UV Animation vars ***
				// Total tiles of Flipbook Texture
				float fbtotaltiles197 = _FlipbookColumnsRowsSpeedStartFrame.x * _FlipbookColumnsRowsSpeedStartFrame.y;
				// Offsets for cols and rows of Flipbook Texture
				float fbcolsoffset197 = 1.0f / _FlipbookColumnsRowsSpeedStartFrame.x;
				float fbrowsoffset197 = 1.0f / _FlipbookColumnsRowsSpeedStartFrame.y;
				// Speed of animation
				float fbspeed197 = _TimeParameters.x * staticSwitch202;
				// UV Tiling (col and row offset)
				float2 fbtiling197 = float2(fbcolsoffset197, fbrowsoffset197);
				// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
				// Calculate current tile linear index
				float fbcurrenttileindex197 = round( fmod( fbspeed197 + _FlipbookColumnsRowsSpeedStartFrame.w, fbtotaltiles197) );
				fbcurrenttileindex197 += ( fbcurrenttileindex197 < 0) ? fbtotaltiles197 : 0;
				// Obtain Offset X coordinate from current tile linear index
				float fblinearindextox197 = round ( fmod ( fbcurrenttileindex197, _FlipbookColumnsRowsSpeedStartFrame.x ) );
				// Multiply Offset X by coloffset
				float fboffsetx197 = fblinearindextox197 * fbcolsoffset197;
				// Obtain Offset Y coordinate from current tile linear index
				float fblinearindextoy197 = round( fmod( ( fbcurrenttileindex197 - fblinearindextox197 ) / _FlipbookColumnsRowsSpeedStartFrame.x, _FlipbookColumnsRowsSpeedStartFrame.y ) );
				// Reverse Y to get tiles from Top to Bottom
				fblinearindextoy197 = (int)(_FlipbookColumnsRowsSpeedStartFrame.y-1) - fblinearindextoy197;
				// Multiply Offset Y by rowoffset
				float fboffsety197 = fblinearindextoy197 * fbrowsoffset197;
				// UV Offset
				float2 fboffset197 = float2(fboffsetx197, fboffsety197);
				// Flipbook UV
				half2 fbuv197 = temp_output_85_0 * fbtiling197 + fboffset197;
				// *** END Flipbook UV Animation vars ***
				#ifdef _USEFLIPBOOK_ON
				half2 staticSwitch211 = fbuv197;
				#else
				half2 staticSwitch211 = temp_output_85_0;
				#endif
				TEXTURE2D(_HeightMap536) = _HeightMap1;
				TEXTURE2D(_HeightMapNoise536) = _HeightMapNoise;
				SamplerState linear_repeat_sampler536 = sampler_Linear_Repeat;
				half _HeightSampleSteps536 = _SampleSteps;
				half3 ase_worldTangent = IN.ase_texcoord6.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord7.xyz;
				half3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				half3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				half3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				half3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				half3 ViewDir536 = ase_tanViewDir;
				half4 texCoord543 = IN.ase_texcoord5;
				texCoord543.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_PARALLAXSTRENGTHCONTROLMETHOD_CONST)
				half staticSwitch546 = _ParallaxStrength;
				#elif defined(_PARALLAXSTRENGTHCONTROLMETHOD_CUSTOMDATA2X)
				half staticSwitch546 = texCoord543.z;
				#else
				half staticSwitch546 = _ParallaxStrength;
				#endif
				half4 appendResult548 = (half4(0.0 , 0.0 , staticSwitch546 , 0.0));
				half4 customData2536 = appendResult548;
				half4 pos536 = IN.ase_texcoord8;
				int _HeightMapNoiseChannel536 = (int)0.0;
				half2 texCoord521 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				half2 uv536 = texCoord521;
				half4 _HeightMap_ST536 = _HeightMap_ST;
				half4 _HeightMapNoise_ST536 = _HeightMapNoise_ST;
				half2 MainTexUV536 = texCoord521;
				half4 MainTex_ST541 = staticSwitch15;
				half4 _MainTex_ST536 = MainTex_ST541;
				half2 localParallax536 = Parallax536( _HeightMap536 , _HeightMapNoise536 , linear_repeat_sampler536 , _HeightSampleSteps536 , ViewDir536 , customData2536 , pos536 , _HeightMapNoiseChannel536 , uv536 , _HeightMap_ST536 , _HeightMapNoise_ST536 , MainTexUV536 , _MainTex_ST536 );
				half4 Parallax_Mapping440 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, uv536 );
				#ifdef _USEPARALLAX_ON
				half4 staticSwitch370 = Parallax_Mapping440;
				#else
				half4 staticSwitch370 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, staticSwitch211 );
				#endif
				half2 appendResult487 = (half2(_NoiseUV.z , _NoiseUV.w));
				half2 appendResult486 = (half2(_NoiseUV.x , _NoiseUV.y));
				half2 texCoord479 = IN.ase_texcoord4.xy * appendResult486 + float2( 0,0 );
				half2 panner477 = ( 1.0 * _Time.y * appendResult487 + texCoord479);
				half simplePerlin2D471 = snoise( panner477 );
				simplePerlin2D471 = simplePerlin2D471*0.5 + 0.5;
				half gradientNoise473 = GradientNoise(panner477,1.0);
				gradientNoise473 = gradientNoise473*0.5 + 0.5;
				half simpleNoise474 = SimpleNoise( panner477 );
				#if defined(_FLOWNOISE_DISABLE)
				half staticSwitch488 = 1.0;
				#elif defined(_FLOWNOISE_SIMPLEX2D)
				half staticSwitch488 = pow( simplePerlin2D471 , _NoiseStrength );
				#elif defined(_FLOWNOISE_GRADIENT)
				half staticSwitch488 = pow( gradientNoise473 , _NoiseStrength );
				#elif defined(_FLOWNOISE_SIMPLE)
				half staticSwitch488 = pow( simpleNoise474 , _NoiseStrength );
				#else
				half staticSwitch488 = 1.0;
				#endif
				half NoiseUV491 = staticSwitch488;
				half4 temp_output_511_0 = ( staticSwitch370 * NoiseUV491 );
				half4 break513 = temp_output_511_0;
				half4 temp_cast_1 = (break513.r).xxxx;
				half4 temp_cast_2 = (break513.g).xxxx;
				half4 temp_cast_3 = (break513.b).xxxx;
				half4 temp_cast_4 = (break513.a).xxxx;
				#if defined(_MAINTEXCHANNEL_RGB)
				half4 staticSwitch32 = temp_output_511_0;
				#elif defined(_MAINTEXCHANNEL_R)
				half4 staticSwitch32 = temp_cast_1;
				#elif defined(_MAINTEXCHANNEL_G)
				half4 staticSwitch32 = temp_cast_2;
				#elif defined(_MAINTEXCHANNEL_B)
				half4 staticSwitch32 = temp_cast_3;
				#elif defined(_MAINTEXCHANNEL_A)
				half4 staticSwitch32 = temp_cast_4;
				#else
				half4 staticSwitch32 = temp_output_511_0;
				#endif
				float ase_lightAtten = 0;
				Light ase_mainLight = GetMainLight( ShadowCoords );
				ase_lightAtten = ase_mainLight.distanceAttenuation * ase_mainLight.shadowAttenuation;
				half3 unpack448 = UnpackNormalScale( SAMPLE_TEXTURE2D( _NormalMap, sampler_NormalMap, staticSwitch211 ), _NormalStrength );
				unpack448.z = lerp( 1, unpack448.z, saturate(_NormalStrength) );
				half3 normalizeResult469 = normalize( unpack448 );
				half3 surf_pos107_g15 = WorldPosition;
				half3 surf_norm107_g15 = ase_worldNormal;
				float2 uv_HeightMap1 = IN.ase_texcoord4.xy * _HeightMap1_ST.xy + _HeightMap1_ST.zw;
				half height107_g15 = SAMPLE_TEXTURE2D( _HeightMap1, sampler_HeightMap1, uv_HeightMap1 ).r;
				half Normal_Strength466 = _NormalStrength;
				half scale107_g15 = Normal_Strength466;
				half3 localPerturbNormal107_g15 = PerturbNormal107_g15( surf_pos107_g15 , surf_norm107_g15 , height107_g15 , scale107_g15 );
				half3 normalizeResult468 = normalize( localPerturbNormal107_g15 );
				half3 Parallax_Normal456 = normalizeResult468;
				#ifdef _USEPARALLAX_ON
				half3 staticSwitch457 = Parallax_Normal456;
				#else
				half3 staticSwitch457 = normalizeResult469;
				#endif
				float3 tanNormal447 = staticSwitch457;
				half3 worldNormal447 = float3(dot(tanToWorld0,tanNormal447), dot(tanToWorld1,tanNormal447), dot(tanToWorld2,tanNormal447));
				half dotResult444 = dot( worldNormal447 , _MainLightPosition.xyz );
				half ase_lightIntensity = max( max( _MainLightColor.r, _MainLightColor.g ), _MainLightColor.b );
				half4 ase_lightColor = float4( _MainLightColor.rgb / ase_lightIntensity, ase_lightIntensity );
				half3 worldPosValue44_g11 = WorldPosition;
				half3 WorldPosition100_g11 = worldPosValue44_g11;
				half3 localAdditionalLightsFlat10x100_g11 = AdditionalLightsFlat10x( WorldPosition100_g11 );
				half3 FlatResult29_g11 = localAdditionalLightsFlat10x100_g11;
				half4 blendOpSrc462 = staticSwitch32;
				half4 blendOpDest462 = ( ( ( ase_lightAtten * ( dotResult444 * ase_lightColor ) * ase_lightColor.a ) * _LightStrength ) + half4( FlatResult29_g11 , 0.0 ) );
				half4 lerpBlendMode462 = lerp(blendOpDest462, (( blendOpSrc462 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpSrc462 - 0.5 ) ) * ( 1.0 - blendOpDest462 ) ) : ( 2.0 * blendOpSrc462 * blendOpDest462 ) ),0.5);
				#ifdef _USELIGHT_ON
				half4 staticSwitch463 = ( saturate( lerpBlendMode462 ));
				#else
				half4 staticSwitch463 = staticSwitch32;
				#endif
				half2 appendResult37 = (half2(_MaskTexST.x , _MaskTexST.y));
				half2 appendResult41 = (half2(_MaskTexST.z , _MaskTexST.w));
				half4 appendResult39 = (half4(appendResult37 , ( appendResult41 * _TimeParameters.x )));
				half4 texCoord48 = IN.ase_texcoord5;
				texCoord48.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				half2 appendResult42 = (half2(texCoord48.x , texCoord48.y));
				half4 appendResult49 = (half4(appendResult37 , appendResult42));
				#if defined(_MASKTEXSTPATTERN_ONLYST)
				half4 staticSwitch47 = _MaskTexST;
				#elif defined(_MASKTEXSTPATTERN_FLOWBYTIME)
				half4 staticSwitch47 = appendResult39;
				#elif defined(_MASKTEXSTPATTERN_CUSTOMDATAXY)
				half4 staticSwitch47 = appendResult49;
				#else
				half4 staticSwitch47 = _MaskTexST;
				#endif
				half4 break44 = staticSwitch47;
				half2 appendResult46 = (half2(break44.x , break44.y));
				half2 appendResult45 = (half2(break44.z , break44.w));
				half2 texCoord43 = IN.ase_texcoord4.xy * appendResult46 + appendResult45;
				half4 tex2DNode36 = SAMPLE_TEXTURE2D( _MaskTexture, sampler_MaskTexture, texCoord43 );
				#if defined(_MASKCHANNEL_R)
				half staticSwitch52 = tex2DNode36.r;
				#elif defined(_MASKCHANNEL_G)
				half staticSwitch52 = tex2DNode36.g;
				#elif defined(_MASKCHANNEL_B)
				half staticSwitch52 = tex2DNode36.b;
				#elif defined(_MASKCHANNEL_A)
				half staticSwitch52 = tex2DNode36.a;
				#else
				half staticSwitch52 = tex2DNode36.r;
				#endif
				half temp_output_77_0 = ( pow( staticSwitch52 , _MaskPower ) * _MaskMultiply );
				#if defined(_MASKUSEFROM1TO0DISSOLVE_DISABLE)
				half staticSwitch236 = temp_output_77_0;
				#elif defined(_MASKUSEFROM1TO0DISSOLVE_CONST)
				half staticSwitch236 = saturate( ( temp_output_77_0 + _MaskAdd ) );
				#elif defined(_MASKUSEFROM1TO0DISSOLVE_CUSTOMDATA2Z)
				half staticSwitch236 = saturate( ( temp_output_77_0 + IN.ase_texcoord9.xy.x ) );
				#else
				half staticSwitch236 = temp_output_77_0;
				#endif
				half4 temp_cast_6 = (1.0).xxxx;
				half4 switchResult212 = (((ase_vface>0)?(_FrontColor):(_BackColor)));
				#ifdef _DOUBLEFACECOLOR_ON
				half4 staticSwitch215 = switchResult212;
				#else
				half4 staticSwitch215 = temp_cast_6;
				#endif
				half4 temp_output_8_0 = ( staticSwitch218 * staticSwitch463 * staticSwitch236 * staticSwitch215 * IN.ase_color );
				#if defined(_CONTROLMETHOD_CONST)
				half staticSwitch281 = _ExternelAlphaValue;
				#elif defined(_CONTROLMETHOD_CUSTOMDATA2W)
				half staticSwitch281 = IN.ase_texcoord9.xy.y;
				#else
				half staticSwitch281 = _ExternelAlphaValue;
				#endif
				half2 appendResult273 = (half2(staticSwitch281 , 0.0));
				half2 appendResult274 = (half2(0.0 , staticSwitch281));
				#if defined(_DIRECTION_VERTICAL)
				half2 staticSwitch245 = appendResult274;
				#elif defined(_DIRECTION_HORIZONTAL)
				half2 staticSwitch245 = appendResult273;
				#else
				half2 staticSwitch245 = appendResult273;
				#endif
				half2 texCoord244 = IN.ase_texcoord4.xy * float2( 1,1 ) + staticSwitch245;
				#ifdef _INVERSEEXTERNELALPHARANGE_ON
				half staticSwitch246 = ( 1.0 - texCoord244.x );
				#else
				half staticSwitch246 = texCoord244.x;
				#endif
				half temp_output_263_0 = ( _ExternelAlphaRangePower * _ExternelAlphaRangeMultiply );
				#ifdef _INVERSEEXTERNELALPHARANGE_ON
				half staticSwitch249 = ( 1.0 - texCoord244.y );
				#else
				half staticSwitch249 = texCoord244.y;
				#endif
				#if defined(_DIRECTION_VERTICAL)
				half staticSwitch276 = ( pow( staticSwitch249 , _ExternelAlphaRangePower ) * temp_output_263_0 );
				#elif defined(_DIRECTION_HORIZONTAL)
				half staticSwitch276 = ( pow( staticSwitch246 , _ExternelAlphaRangePower ) * temp_output_263_0 );
				#else
				half staticSwitch276 = ( pow( staticSwitch246 , _ExternelAlphaRangePower ) * temp_output_263_0 );
				#endif
				half2 texCoord251 = IN.ase_texcoord4.xy * float2( 1,1 ) + staticSwitch245;
				half temp_output_264_0 = saturate( ( pow( ( texCoord251.x * ( 1.0 - texCoord251.x ) ) , _ExternelAlphaRangePower ) * temp_output_263_0 ) );
				#ifdef _INVERSEEXTERNELALPHARANGE_ON
				half staticSwitch268 = ( 1.0 - temp_output_264_0 );
				#else
				half staticSwitch268 = temp_output_264_0;
				#endif
				half temp_output_265_0 = saturate( ( pow( ( texCoord251.y * ( 1.0 - texCoord251.y ) ) , _ExternelAlphaRangePower ) * temp_output_263_0 ) );
				#ifdef _INVERSEEXTERNELALPHARANGE_ON
				half staticSwitch269 = ( 1.0 - temp_output_265_0 );
				#else
				half staticSwitch269 = temp_output_265_0;
				#endif
				#if defined(_DIRECTION_VERTICAL)
				half staticSwitch250 = staticSwitch269;
				#elif defined(_DIRECTION_HORIZONTAL)
				half staticSwitch250 = staticSwitch268;
				#else
				half staticSwitch250 = staticSwitch268;
				#endif
				#if defined(_EXTERNALALPHAOPTION_DISABLE)
				half staticSwitch270 = 1.0;
				#elif defined(_EXTERNALALPHAOPTION_LINE)
				half staticSwitch270 = staticSwitch276;
				#elif defined(_EXTERNALALPHAOPTION_GRADIENT)
				half staticSwitch270 = staticSwitch250;
				#else
				half staticSwitch270 = 1.0;
				#endif
				half Externel_Alpha283 = saturate( staticSwitch270 );
				half4 break371 = staticSwitch370;
				#if defined(_ALPHACHANNEL_R)
				half staticSwitch33 = break371.r;
				#elif defined(_ALPHACHANNEL_G)
				half staticSwitch33 = break371.g;
				#elif defined(_ALPHACHANNEL_B)
				half staticSwitch33 = break371.b;
				#elif defined(_ALPHACHANNEL_A)
				half staticSwitch33 = break371.a;
				#else
				half staticSwitch33 = break371.a;
				#endif
				#ifdef _MASKAFFECTALPHA_ON
				half staticSwitch53 = staticSwitch236;
				#else
				half staticSwitch53 = 1.0;
				#endif
				float4 screenPos = IN.ase_texcoord10;
				half4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth57 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				half distanceDepth57 = abs( ( screenDepth57 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DepthFade ) );
				#ifdef _USEDEPTHFADE_ON
				half staticSwitch59 = saturate( distanceDepth57 );
				#else
				half staticSwitch59 = 1.0;
				#endif
				half customEye91 = IN.ase_texcoord3.w;
				half cameraDepthFade91 = (( customEye91 -_ProjectionParams.y - _CameraFadeOffset ) / _CameraFadeLength);
				#ifdef _USECAMERADEPTH_ON
				half staticSwitch98 = cameraDepthFade91;
				#else
				half staticSwitch98 = 1.0;
				#endif
				half temp_output_55_0 = saturate( ( staticSwitch33 * IN.ase_color.a * staticSwitch53 * staticSwitch59 * _FinalAlphaDeepen * staticSwitch98 ) );
				#ifdef _IMPACTALPHA_ON
				half staticSwitch228 = ( Fresnel223 * temp_output_55_0 );
				#else
				half staticSwitch228 = temp_output_55_0;
				#endif
				half temp_output_285_0 = ( Externel_Alpha283 * staticSwitch228 );
				half smoothstepResult230 = smoothstep( _Step , ( _Step + _Softness ) , temp_output_285_0);
				#if defined(_STEPOPTION_STEP)
				half staticSwitch231 = step( _Step , temp_output_285_0 );
				#elif defined(_STEPOPTION_SMOOTHSTEP)
				half staticSwitch231 = smoothstepResult230;
				#else
				half staticSwitch231 = step( _Step , temp_output_285_0 );
				#endif
				#ifdef _ALPHAUSESTEP_ON
				half staticSwitch101 = staticSwitch231;
				#else
				half staticSwitch101 = temp_output_285_0;
				#endif
				half grayscale301 = dot((( temp_output_8_0 * staticSwitch101 )).rgb, float3(0.299,0.587,0.114));
				half2 temp_cast_7 = (saturate( ( grayscale301 + _GrayScaleOffset ) )).xx;
				#ifdef _USECOLORRAMP_ON
				half4 staticSwitch305 = ( _ColorRampEmission * SAMPLE_TEXTURE2D( _ColorRamp, sampler_Linear_Clamp, temp_cast_7 ) );
				#else
				half4 staticSwitch305 = temp_output_8_0;
				#endif
				#ifdef _RAMPMULTIPLYVERTEXCOLOR_ON
				half4 staticSwitch514 = ( IN.ase_color * staticSwitch305 );
				#else
				half4 staticSwitch514 = staticSwitch305;
				#endif
				half4 temp_cast_8 = (Externel_Alpha283).xxxx;
				#ifdef _EXTERNELALPHACHECKER_ON
				half4 staticSwitch292 = temp_cast_8;
				#else
				half4 staticSwitch292 = staticSwitch514;
				#endif
				
				#ifdef _EXTERNELALPHACHECKER_ON
				half staticSwitch287 = 1.0;
				#else
				half staticSwitch287 = staticSwitch101;
				#endif
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = staticSwitch292.rgb;
				float Alpha = staticSwitch287;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				return half4( Color, Alpha );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
			
			#pragma multi_compile_instancing
			#define _RECEIVE_SHADOWS_OFF 1
			#define ASE_SRP_VERSION -1
			#define REQUIRE_DEPTH_TEXTURE 1
			#define ASE_USING_SAMPLING_MACROS 1

			
			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _USEVERTEXOFFSET_ON
			#pragma shader_feature_local _EXTERNELALPHACHECKER_ON
			#pragma shader_feature_local _ALPHAUSESTEP_ON
			#pragma shader_feature_local _EXTERNALALPHAOPTION_DISABLE _EXTERNALALPHAOPTION_LINE _EXTERNALALPHAOPTION_GRADIENT
			#pragma shader_feature_local _DIRECTION_VERTICAL _DIRECTION_HORIZONTAL
			#pragma shader_feature_local _INVERSEEXTERNELALPHARANGE_ON
			#pragma shader_feature_local _CONTROLMETHOD_CONST _CONTROLMETHOD_CUSTOMDATA2W
			#pragma shader_feature_local _IMPACTALPHA_ON
			#pragma shader_feature_local _ALPHACHANNEL_R _ALPHACHANNEL_G _ALPHACHANNEL_B _ALPHACHANNEL_A
			#pragma shader_feature_local _USEPARALLAX_ON
			#pragma shader_feature_local _USEFLIPBOOK_ON
			#pragma shader_feature_local _MAINTEXSTPATTERN_ONLYST _MAINTEXSTPATTERN_FLOWBYTIME _MAINTEXSTPATTERN_CUSTOMDATAXY
			#pragma shader_feature_local _DISTORTCHANNEL_R _DISTORTCHANNEL_G _DISTORTCHANNEL_B _DISTORTCHANNEL_A
			#pragma shader_feature_local _DISTORTTEXSTPATTERN_ONLYST _DISTORTTEXSTPATTERN_FLOWBYTIME _DISTORTTEXSTPATTERN_CUSTOMWT
			#pragma shader_feature_local _PARALLAXSTRENGTHCONTROLMETHOD_CONST _PARALLAXSTRENGTHCONTROLMETHOD_CUSTOMDATA2X
			#pragma shader_feature_local _FLIPBOOKMODE_CONSTANT _FLIPBOOKMODE_SPEED
			#pragma shader_feature_local _MASKAFFECTALPHA_ON
			#pragma shader_feature_local _MASKUSEFROM1TO0DISSOLVE_DISABLE _MASKUSEFROM1TO0DISSOLVE_CONST _MASKUSEFROM1TO0DISSOLVE_CUSTOMDATA2Z
			#pragma shader_feature_local _MASKCHANNEL_R _MASKCHANNEL_G _MASKCHANNEL_B _MASKCHANNEL_A
			#pragma shader_feature_local _MASKTEXSTPATTERN_ONLYST _MASKTEXSTPATTERN_FLOWBYTIME _MASKTEXSTPATTERN_CUSTOMDATAXY
			#pragma shader_feature_local _USEDEPTHFADE_ON
			#pragma shader_feature_local _USECAMERADEPTH_ON
			#pragma shader_feature_local _INVERSERANGE_ON
			#pragma shader_feature_local _STEPOPTION_STEP _STEPOPTION_SMOOTHSTEP


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				half4 ase_tangent : TANGENT;
				half4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_color : COLOR;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _FrontColor;
			half4 _HeightMap1_ST;
			half4 _BackColor;
			half4 _OffsetTex_ST;
			half4 _MainColor;
			half4 _FresnelColor;
			half4 _NoiseUV;
			half4 _MainTexST;
			half4 _DistortTexST;
			half4 _MaskTexST;
			half4 _FlipbookColumnsRowsSpeedStartFrame;
			half4 _HeightMapNoise_ST;
			half4 _HeightMap_ST;
			half3 _AxisStrength;
			half _BlendMode;
			half _ColorRampEmission;
			half _ExternelAlphaRangeMultiply;
			half _ExternelAlphaRangePower;
			half _DepthFade;
			half _FinalAlphaDeepen;
			half _CameraFadeLength;
			half _CameraFadeOffset;
			half _Step;
			half _ExternelAlphaValue;
			half _MaskAdd;
			half _NoiseStrength;
			half _MaskPower;
			half _LightStrength;
			half _NormalStrength;
			half _Softness;
			half _ParallaxStrength;
			half _SampleSteps;
			half _DistortStrength;
			half _FresnelPower;
			half _FresnelScale;
			half _ZWriteSet;
			half _CullMode;
			half _ZTestSetting;
			half _MaskMultiply;
			half _GrayScaleOffset;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			TEXTURE2D(_OffsetTexture);
			SAMPLER(sampler_OffsetTexture);
			TEXTURE2D(_MainTex);
			TEXTURE2D(_DistortTexture);
			SAMPLER(sampler_DistortTexture);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_HeightMap1);
			TEXTURE2D(_HeightMapNoise);
			SAMPLER(sampler_Linear_Repeat);
			TEXTURE2D(_MaskTexture);
			SAMPLER(sampler_MaskTexture);
			uniform float4 _CameraDepthTexture_TexelSize;


			half2 Parallax536( TEXTURE2D(_HeightMap), TEXTURE2D(_HeightMapNoise), SamplerState linear_repeat_sampler, half _HeightSampleSteps, half3 ViewDir, half4 customData2, half4 pos, int _HeightMapNoiseChannel, inout half2 uv, half4 _HeightMap_ST, half4 _HeightMapNoise_ST, half2 MainTexUV, half4 _MainTex_ST )
			{
				half HeightValue = SAMPLE_TEXTURE2D(_HeightMap, linear_repeat_sampler, TRANSFORM_TEX(uv.xy, _HeightMap)).r;
												//half HeightValue = tex2D(_HeightMap , TRANSFORM_TEX(uv.xy, _HeightMap));
												                    //const int minLayers = 32;
												                    //const int maxLayers = 64;
												                    //float viewDirOptimize = max(abs(dot(float3(0,0,1),normalize(o.ViewDir))),0) * maxLayers;
												                    float numLayers = _HeightSampleSteps;
												                    float layerDepth = 1 / numLayers;
												                    float currentLayerDepth = 0;
												                    float2 P = ViewDir.xy * customData2.z / pos.w; //(opration: pos.w可以減少因鏡頭距離太遠而產生過高的偏移)
												                    float2 deltaTexCoords = P / numLayers;
												                    float2 currentTexCoords = uv.xy;
												                    float currentDepthMapValue = HeightValue;
												                    half HeightMapNoise = SAMPLE_TEXTURE2D(_HeightMapNoise, linear_repeat_sampler, TRANSFORM_TEX(uv.xy , _HeightMapNoise))[
												                        _HeightMapNoiseChannel];
																	//half HeightMapNoise = tex2D(_HeightMapNoise, TRANSFORM_TEX(uv.xy , _HeightMapNoise)).r;	
												                    [loop]
												                    while (currentLayerDepth < currentDepthMapValue) {
												                        currentTexCoords -= deltaTexCoords * HeightMapNoise;
												                        currentDepthMapValue = SAMPLE_TEXTURE2D_LOD(_HeightMap, linear_repeat_sampler, TRANSFORM_TEX(currentTexCoords, _HeightMap), 0).r;
																		//currentDepthMapValue = tex2Dlod(_HeightMap , float4(TRANSFORM_TEX(currentTexCoords, _HeightMap) , 0 , 0)).r;
												                        currentLayerDepth += layerDepth;
												                    }
												                    /*註記:由於下面的計算方式類似RayMarching的遞進式，且會拿當前的值與HeightMap值做對比再決定是否繼續往下跑，因此Unroll(一次性展開所有計算方式)並不划算。
												                    GPU的if-statement並不會跳過fail情況的計算，而是先進行計算在取決於當前條件是否成功。因此根據當前情況進行loop跳轉會比較合適。
												                    [unroll(32)]
												                    while(currentLayerDepth<currentDepthMapValue){
												                        currentTexCoords -= deltaTexCoords;
												                        currentDepthMapValue = tex2D(_HeightMap,currentTexCoords).r;
												                        currentLayerDepth += layerDepth;
												                    }
												註記:如果不使用Unroll則會報錯,主要原因為tex2D並不能在loop標籤下執行。因為GPU是以每四個像素一次進行著色，而fragment需要透過像素之間的UV差距來判斷
												要使用的mipmaps。而動態分支對於不同的像素計算方式無法確定，所以禁止使用tex2D。
												但可以透過tex2Dlod或tex2DGrad直接指定mipmap等級，否則就需要宣告unroll標籤。*/
												                    float2 preTexCoords = currentTexCoords + deltaTexCoords;
												                    float beforeDepth = SAMPLE_TEXTURE2D(_HeightMap, linear_repeat_sampler, TRANSFORM_TEX(preTexCoords,_HeightMap)).r - currentLayerDepth + layerDepth;
																	//float beforeDepth = tex2D(_HeightMap , TRANSFORM_TEX(preTexCoords,_HeightMap)).r - currentLayerDepth + layerDepth;
												                    float afterDepth = currentDepthMapValue - currentLayerDepth;
												                    float weight = afterDepth / (afterDepth - beforeDepth);
												                    float2 finalTexCoords = preTexCoords * weight + currentTexCoords * (1 - weight);
												                    //if( finalTexCoords.x>1 || finalTexCoords.y>1 || finalTexCoords.x<0 || finalTexCoords.y<0 )
												                    //   discard;
												                    MainTexUV = TRANSFORM_TEX(finalTexCoords, _MainTex);
												                    uv.xy = finalTexCoords;
												return MainTexUV;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				half2 appendResult186 = (half2(_OffsetTex_ST.z , _OffsetTex_ST.w));
				half2 appendResult185 = (half2(_OffsetTex_ST.x , _OffsetTex_ST.y));
				half2 texCoord176 = v.ase_texcoord * appendResult185 + float2( 0,0 );
				half2 panner181 = ( 1.0 * _Time.y * appendResult186 + texCoord176);
				#ifdef _USEVERTEXOFFSET_ON
				half3 staticSwitch108 = ( ( (-0.5 + (SAMPLE_TEXTURE2D_LOD( _OffsetTexture, sampler_OffsetTexture, panner181, 0.0 ).r - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) * _AxisStrength ) + float3( 0,0,0 ) );
				#else
				half3 staticSwitch108 = float3( 0,0,0 );
				#endif
				half3 Vertex_Offset_Output290 = staticSwitch108;
				
				half3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord5.xyz = ase_worldTangent;
				half3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord6.xyz = ase_worldNormal;
				half ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord7.xyz = ase_worldBitangent;
				float4 ase_clipPos = TransformObjectToHClip((v.vertex).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord9 = screenPos;
				half3 customSurfaceDepth91 = v.vertex.xyz;
				half customEye91 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth91)).z;
				o.ase_texcoord3.z = customEye91;
				
				o.ase_texcoord2 = v.ase_texcoord;
				o.ase_texcoord3.xy = v.ase_texcoord2.xy;
				o.ase_texcoord4 = v.ase_texcoord1;
				o.ase_texcoord8 = v.vertex;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
				o.ase_texcoord7.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Vertex_Offset_Output290;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.clipPos = TransformWorldToHClip( positionWS );
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = o.clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				half4 ase_tangent : TANGENT;
				half4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_tangent = v.ase_tangent;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				#if defined(_CONTROLMETHOD_CONST)
				half staticSwitch281 = _ExternelAlphaValue;
				#elif defined(_CONTROLMETHOD_CUSTOMDATA2W)
				half staticSwitch281 = IN.ase_texcoord3.xy.y;
				#else
				half staticSwitch281 = _ExternelAlphaValue;
				#endif
				half2 appendResult273 = (half2(staticSwitch281 , 0.0));
				half2 appendResult274 = (half2(0.0 , staticSwitch281));
				#if defined(_DIRECTION_VERTICAL)
				half2 staticSwitch245 = appendResult274;
				#elif defined(_DIRECTION_HORIZONTAL)
				half2 staticSwitch245 = appendResult273;
				#else
				half2 staticSwitch245 = appendResult273;
				#endif
				half2 texCoord244 = IN.ase_texcoord2.xy * float2( 1,1 ) + staticSwitch245;
				#ifdef _INVERSEEXTERNELALPHARANGE_ON
				half staticSwitch246 = ( 1.0 - texCoord244.x );
				#else
				half staticSwitch246 = texCoord244.x;
				#endif
				half temp_output_263_0 = ( _ExternelAlphaRangePower * _ExternelAlphaRangeMultiply );
				#ifdef _INVERSEEXTERNELALPHARANGE_ON
				half staticSwitch249 = ( 1.0 - texCoord244.y );
				#else
				half staticSwitch249 = texCoord244.y;
				#endif
				#if defined(_DIRECTION_VERTICAL)
				half staticSwitch276 = ( pow( staticSwitch249 , _ExternelAlphaRangePower ) * temp_output_263_0 );
				#elif defined(_DIRECTION_HORIZONTAL)
				half staticSwitch276 = ( pow( staticSwitch246 , _ExternelAlphaRangePower ) * temp_output_263_0 );
				#else
				half staticSwitch276 = ( pow( staticSwitch246 , _ExternelAlphaRangePower ) * temp_output_263_0 );
				#endif
				half2 texCoord251 = IN.ase_texcoord2.xy * float2( 1,1 ) + staticSwitch245;
				half temp_output_264_0 = saturate( ( pow( ( texCoord251.x * ( 1.0 - texCoord251.x ) ) , _ExternelAlphaRangePower ) * temp_output_263_0 ) );
				#ifdef _INVERSEEXTERNELALPHARANGE_ON
				half staticSwitch268 = ( 1.0 - temp_output_264_0 );
				#else
				half staticSwitch268 = temp_output_264_0;
				#endif
				half temp_output_265_0 = saturate( ( pow( ( texCoord251.y * ( 1.0 - texCoord251.y ) ) , _ExternelAlphaRangePower ) * temp_output_263_0 ) );
				#ifdef _INVERSEEXTERNELALPHARANGE_ON
				half staticSwitch269 = ( 1.0 - temp_output_265_0 );
				#else
				half staticSwitch269 = temp_output_265_0;
				#endif
				#if defined(_DIRECTION_VERTICAL)
				half staticSwitch250 = staticSwitch269;
				#elif defined(_DIRECTION_HORIZONTAL)
				half staticSwitch250 = staticSwitch268;
				#else
				half staticSwitch250 = staticSwitch268;
				#endif
				#if defined(_EXTERNALALPHAOPTION_DISABLE)
				half staticSwitch270 = 1.0;
				#elif defined(_EXTERNALALPHAOPTION_LINE)
				half staticSwitch270 = staticSwitch276;
				#elif defined(_EXTERNALALPHAOPTION_GRADIENT)
				half staticSwitch270 = staticSwitch250;
				#else
				half staticSwitch270 = 1.0;
				#endif
				half Externel_Alpha283 = saturate( staticSwitch270 );
				half2 appendResult18 = (half2(_MainTexST.x , _MainTexST.y));
				half2 appendResult19 = (half2(_MainTexST.z , _MainTexST.w));
				half4 appendResult23 = (half4(appendResult18 , ( appendResult19 * _TimeParameters.x )));
				half4 texCoord12 = IN.ase_texcoord2;
				texCoord12.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				half2 appendResult24 = (half2(texCoord12.z , texCoord12.w));
				half4 appendResult25 = (half4(appendResult18 , appendResult24));
				#if defined(_MAINTEXSTPATTERN_ONLYST)
				half4 staticSwitch15 = _MainTexST;
				#elif defined(_MAINTEXSTPATTERN_FLOWBYTIME)
				half4 staticSwitch15 = appendResult23;
				#elif defined(_MAINTEXSTPATTERN_CUSTOMDATAXY)
				half4 staticSwitch15 = appendResult25;
				#else
				half4 staticSwitch15 = _MainTexST;
				#endif
				half4 break28 = staticSwitch15;
				half2 appendResult29 = (half2(break28.x , break28.y));
				half2 appendResult31 = (half2(break28.z , break28.w));
				half2 texCoord11 = IN.ase_texcoord2.xy * appendResult29 + appendResult31;
				half2 appendResult69 = (half2(_DistortTexST.x , _DistortTexST.y));
				half2 appendResult73 = (half2(_DistortTexST.z , _DistortTexST.w));
				half4 appendResult71 = (half4(appendResult69 , ( appendResult73 * _TimeParameters.x )));
				half2 appendResult207 = (half2(_DistortTexST.x , _DistortTexST.y));
				half4 texCoord205 = IN.ase_texcoord4;
				texCoord205.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				half2 appendResult208 = (half2(texCoord205.z , texCoord205.w));
				half4 appendResult206 = (half4(appendResult207 , appendResult208));
				#if defined(_PARALLAXSTRENGTHCONTROLMETHOD_CONST)
				half4 staticSwitch549 = appendResult206;
				#elif defined(_PARALLAXSTRENGTHCONTROLMETHOD_CUSTOMDATA2X)
				half4 staticSwitch549 = _DistortTexST;
				#else
				half4 staticSwitch549 = appendResult206;
				#endif
				#if defined(_DISTORTTEXSTPATTERN_ONLYST)
				half4 staticSwitch74 = _DistortTexST;
				#elif defined(_DISTORTTEXSTPATTERN_FLOWBYTIME)
				half4 staticSwitch74 = appendResult71;
				#elif defined(_DISTORTTEXSTPATTERN_CUSTOMWT)
				half4 staticSwitch74 = staticSwitch549;
				#else
				half4 staticSwitch74 = _DistortTexST;
				#endif
				half4 break66 = staticSwitch74;
				half2 appendResult68 = (half2(break66.x , break66.y));
				half2 appendResult67 = (half2(break66.z , break66.w));
				half2 texCoord65 = IN.ase_texcoord2.xy * appendResult68 + appendResult67;
				half4 tex2DNode64 = SAMPLE_TEXTURE2D( _DistortTexture, sampler_DistortTexture, texCoord65 );
				#if defined(_DISTORTCHANNEL_R)
				half staticSwitch81 = tex2DNode64.r;
				#elif defined(_DISTORTCHANNEL_G)
				half staticSwitch81 = tex2DNode64.g;
				#elif defined(_DISTORTCHANNEL_B)
				half staticSwitch81 = tex2DNode64.b;
				#elif defined(_DISTORTCHANNEL_A)
				half staticSwitch81 = tex2DNode64.a;
				#else
				half staticSwitch81 = tex2DNode64.r;
				#endif
				half DistortOutput84 = ( staticSwitch81 * _DistortStrength );
				half2 temp_output_85_0 = ( texCoord11 + DistortOutput84 );
				#if defined(_FLIPBOOKMODE_CONSTANT)
				half staticSwitch202 = ( _FlipbookColumnsRowsSpeedStartFrame.z / _TimeParameters.x );
				#elif defined(_FLIPBOOKMODE_SPEED)
				half staticSwitch202 = _FlipbookColumnsRowsSpeedStartFrame.z;
				#else
				half staticSwitch202 = ( _FlipbookColumnsRowsSpeedStartFrame.z / _TimeParameters.x );
				#endif
				// *** BEGIN Flipbook UV Animation vars ***
				// Total tiles of Flipbook Texture
				float fbtotaltiles197 = _FlipbookColumnsRowsSpeedStartFrame.x * _FlipbookColumnsRowsSpeedStartFrame.y;
				// Offsets for cols and rows of Flipbook Texture
				float fbcolsoffset197 = 1.0f / _FlipbookColumnsRowsSpeedStartFrame.x;
				float fbrowsoffset197 = 1.0f / _FlipbookColumnsRowsSpeedStartFrame.y;
				// Speed of animation
				float fbspeed197 = _TimeParameters.x * staticSwitch202;
				// UV Tiling (col and row offset)
				float2 fbtiling197 = float2(fbcolsoffset197, fbrowsoffset197);
				// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
				// Calculate current tile linear index
				float fbcurrenttileindex197 = round( fmod( fbspeed197 + _FlipbookColumnsRowsSpeedStartFrame.w, fbtotaltiles197) );
				fbcurrenttileindex197 += ( fbcurrenttileindex197 < 0) ? fbtotaltiles197 : 0;
				// Obtain Offset X coordinate from current tile linear index
				float fblinearindextox197 = round ( fmod ( fbcurrenttileindex197, _FlipbookColumnsRowsSpeedStartFrame.x ) );
				// Multiply Offset X by coloffset
				float fboffsetx197 = fblinearindextox197 * fbcolsoffset197;
				// Obtain Offset Y coordinate from current tile linear index
				float fblinearindextoy197 = round( fmod( ( fbcurrenttileindex197 - fblinearindextox197 ) / _FlipbookColumnsRowsSpeedStartFrame.x, _FlipbookColumnsRowsSpeedStartFrame.y ) );
				// Reverse Y to get tiles from Top to Bottom
				fblinearindextoy197 = (int)(_FlipbookColumnsRowsSpeedStartFrame.y-1) - fblinearindextoy197;
				// Multiply Offset Y by rowoffset
				float fboffsety197 = fblinearindextoy197 * fbrowsoffset197;
				// UV Offset
				float2 fboffset197 = float2(fboffsetx197, fboffsety197);
				// Flipbook UV
				half2 fbuv197 = temp_output_85_0 * fbtiling197 + fboffset197;
				// *** END Flipbook UV Animation vars ***
				#ifdef _USEFLIPBOOK_ON
				half2 staticSwitch211 = fbuv197;
				#else
				half2 staticSwitch211 = temp_output_85_0;
				#endif
				TEXTURE2D(_HeightMap536) = _HeightMap1;
				TEXTURE2D(_HeightMapNoise536) = _HeightMapNoise;
				SamplerState linear_repeat_sampler536 = sampler_Linear_Repeat;
				half _HeightSampleSteps536 = _SampleSteps;
				half3 ase_worldTangent = IN.ase_texcoord5.xyz;
				half3 ase_worldNormal = IN.ase_texcoord6.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord7.xyz;
				half3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				half3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				half3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				half3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				half3 ViewDir536 = ase_tanViewDir;
				half4 texCoord543 = IN.ase_texcoord4;
				texCoord543.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_PARALLAXSTRENGTHCONTROLMETHOD_CONST)
				half staticSwitch546 = _ParallaxStrength;
				#elif defined(_PARALLAXSTRENGTHCONTROLMETHOD_CUSTOMDATA2X)
				half staticSwitch546 = texCoord543.z;
				#else
				half staticSwitch546 = _ParallaxStrength;
				#endif
				half4 appendResult548 = (half4(0.0 , 0.0 , staticSwitch546 , 0.0));
				half4 customData2536 = appendResult548;
				half4 pos536 = IN.ase_texcoord8;
				int _HeightMapNoiseChannel536 = (int)0.0;
				half2 texCoord521 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				half2 uv536 = texCoord521;
				half4 _HeightMap_ST536 = _HeightMap_ST;
				half4 _HeightMapNoise_ST536 = _HeightMapNoise_ST;
				half2 MainTexUV536 = texCoord521;
				half4 MainTex_ST541 = staticSwitch15;
				half4 _MainTex_ST536 = MainTex_ST541;
				half2 localParallax536 = Parallax536( _HeightMap536 , _HeightMapNoise536 , linear_repeat_sampler536 , _HeightSampleSteps536 , ViewDir536 , customData2536 , pos536 , _HeightMapNoiseChannel536 , uv536 , _HeightMap_ST536 , _HeightMapNoise_ST536 , MainTexUV536 , _MainTex_ST536 );
				half4 Parallax_Mapping440 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, uv536 );
				#ifdef _USEPARALLAX_ON
				half4 staticSwitch370 = Parallax_Mapping440;
				#else
				half4 staticSwitch370 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, staticSwitch211 );
				#endif
				half4 break371 = staticSwitch370;
				#if defined(_ALPHACHANNEL_R)
				half staticSwitch33 = break371.r;
				#elif defined(_ALPHACHANNEL_G)
				half staticSwitch33 = break371.g;
				#elif defined(_ALPHACHANNEL_B)
				half staticSwitch33 = break371.b;
				#elif defined(_ALPHACHANNEL_A)
				half staticSwitch33 = break371.a;
				#else
				half staticSwitch33 = break371.a;
				#endif
				half2 appendResult37 = (half2(_MaskTexST.x , _MaskTexST.y));
				half2 appendResult41 = (half2(_MaskTexST.z , _MaskTexST.w));
				half4 appendResult39 = (half4(appendResult37 , ( appendResult41 * _TimeParameters.x )));
				half4 texCoord48 = IN.ase_texcoord4;
				texCoord48.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				half2 appendResult42 = (half2(texCoord48.x , texCoord48.y));
				half4 appendResult49 = (half4(appendResult37 , appendResult42));
				#if defined(_MASKTEXSTPATTERN_ONLYST)
				half4 staticSwitch47 = _MaskTexST;
				#elif defined(_MASKTEXSTPATTERN_FLOWBYTIME)
				half4 staticSwitch47 = appendResult39;
				#elif defined(_MASKTEXSTPATTERN_CUSTOMDATAXY)
				half4 staticSwitch47 = appendResult49;
				#else
				half4 staticSwitch47 = _MaskTexST;
				#endif
				half4 break44 = staticSwitch47;
				half2 appendResult46 = (half2(break44.x , break44.y));
				half2 appendResult45 = (half2(break44.z , break44.w));
				half2 texCoord43 = IN.ase_texcoord2.xy * appendResult46 + appendResult45;
				half4 tex2DNode36 = SAMPLE_TEXTURE2D( _MaskTexture, sampler_MaskTexture, texCoord43 );
				#if defined(_MASKCHANNEL_R)
				half staticSwitch52 = tex2DNode36.r;
				#elif defined(_MASKCHANNEL_G)
				half staticSwitch52 = tex2DNode36.g;
				#elif defined(_MASKCHANNEL_B)
				half staticSwitch52 = tex2DNode36.b;
				#elif defined(_MASKCHANNEL_A)
				half staticSwitch52 = tex2DNode36.a;
				#else
				half staticSwitch52 = tex2DNode36.r;
				#endif
				half temp_output_77_0 = ( pow( staticSwitch52 , _MaskPower ) * _MaskMultiply );
				#if defined(_MASKUSEFROM1TO0DISSOLVE_DISABLE)
				half staticSwitch236 = temp_output_77_0;
				#elif defined(_MASKUSEFROM1TO0DISSOLVE_CONST)
				half staticSwitch236 = saturate( ( temp_output_77_0 + _MaskAdd ) );
				#elif defined(_MASKUSEFROM1TO0DISSOLVE_CUSTOMDATA2Z)
				half staticSwitch236 = saturate( ( temp_output_77_0 + IN.ase_texcoord3.xy.x ) );
				#else
				half staticSwitch236 = temp_output_77_0;
				#endif
				#ifdef _MASKAFFECTALPHA_ON
				half staticSwitch53 = staticSwitch236;
				#else
				half staticSwitch53 = 1.0;
				#endif
				float4 screenPos = IN.ase_texcoord9;
				half4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth57 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				half distanceDepth57 = abs( ( screenDepth57 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DepthFade ) );
				#ifdef _USEDEPTHFADE_ON
				half staticSwitch59 = saturate( distanceDepth57 );
				#else
				half staticSwitch59 = 1.0;
				#endif
				half customEye91 = IN.ase_texcoord3.z;
				half cameraDepthFade91 = (( customEye91 -_ProjectionParams.y - _CameraFadeOffset ) / _CameraFadeLength);
				#ifdef _USECAMERADEPTH_ON
				half staticSwitch98 = cameraDepthFade91;
				#else
				half staticSwitch98 = 1.0;
				#endif
				half temp_output_55_0 = saturate( ( staticSwitch33 * IN.ase_color.a * staticSwitch53 * staticSwitch59 * _FinalAlphaDeepen * staticSwitch98 ) );
				half fresnelNdotV217 = dot( ase_worldNormal, ase_worldViewDir );
				half fresnelNode217 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV217, _FresnelPower ) );
				half temp_output_225_0 = saturate( abs( fresnelNode217 ) );
				#ifdef _INVERSERANGE_ON
				half staticSwitch226 = ( 1.0 - temp_output_225_0 );
				#else
				half staticSwitch226 = temp_output_225_0;
				#endif
				half Fresnel223 = staticSwitch226;
				#ifdef _IMPACTALPHA_ON
				half staticSwitch228 = ( Fresnel223 * temp_output_55_0 );
				#else
				half staticSwitch228 = temp_output_55_0;
				#endif
				half temp_output_285_0 = ( Externel_Alpha283 * staticSwitch228 );
				half smoothstepResult230 = smoothstep( _Step , ( _Step + _Softness ) , temp_output_285_0);
				#if defined(_STEPOPTION_STEP)
				half staticSwitch231 = step( _Step , temp_output_285_0 );
				#elif defined(_STEPOPTION_SMOOTHSTEP)
				half staticSwitch231 = smoothstepResult230;
				#else
				half staticSwitch231 = step( _Step , temp_output_285_0 );
				#endif
				#ifdef _ALPHAUSESTEP_ON
				half staticSwitch101 = staticSwitch231;
				#else
				half staticSwitch101 = temp_output_285_0;
				#endif
				#ifdef _EXTERNELALPHACHECKER_ON
				half staticSwitch287 = 1.0;
				#else
				half staticSwitch287 = staticSwitch101;
				#endif
				
				float Alpha = staticSwitch287;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

	
	}
	CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=19201
Node;AmplifyShaderEditor.CommentaryNode;470;-3813.725,-1064.104;Inherit;False;2506.858;557.9319;Comment;17;446;447;444;449;450;451;452;453;457;454;464;465;459;466;458;448;469;Light Setting;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;455;-2786.279,4928.441;Inherit;False;3156.408;1610.234;Comment;26;543;547;548;546;542;440;456;468;467;539;540;538;536;532;531;530;525;523;522;521;520;519;518;517;551;552;Parallax;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;381;666.0778,-480.619;Inherit;False;1392.91;539.0904;Comment;12;300;302;306;307;305;301;304;303;308;299;309;515;Color Ramp;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;284;328.1907,567.3606;Inherit;False;892;329.7125;Comment;6;102;232;100;230;231;233;Step;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;282;-2540.176,3221.599;Inherit;False;4735.025;1249.878;Comment;39;270;278;272;275;281;273;274;245;276;246;268;269;250;249;262;261;267;266;264;265;258;263;252;260;257;256;255;254;253;251;248;244;247;283;293;294;295;296;297;Externel Alpha;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;234;447.353,-885.9055;Inherit;False;1640.892;392.9325;Comment;8;241;217;219;220;225;227;223;226;Fresnel;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;88;-2736.91,2055.3;Inherit;False;2576.743;588.2839;Comment;21;208;207;206;205;69;73;71;74;84;80;83;81;64;65;68;67;66;70;72;75;549;Distort Setting;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;75;-2688.91,2119.797;Inherit;False;Property;_DistortTexST;DistortTex ST;15;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;72;-2491.643,2354.184;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-2324.642,2262.183;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;69;-2453.643,2171.183;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;71;-2185.642,2171.183;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;34;-3914.443,-116.4889;Inherit;False;2468.742;737.567;Comment;28;197;202;204;201;200;370;378;374;15;25;23;24;22;18;12;19;21;17;373;372;28;211;9;85;11;87;29;31;MainTex Setting;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;62;-2687.7,668.1826;Inherit;False;2426.075;673.5352;Comment;23;77;54;76;79;52;78;36;43;46;45;44;47;39;49;42;38;37;41;40;48;50;237;240;Mask Setting;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;66;-1738.94,2127.61;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector4Node;50;-2637.7,784.8586;Inherit;False;Property;_MaskTexST;MaskTex ST;6;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;41;-2402.433,927.2446;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-2489.812,1137.718;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;40;-2440.433,1019.245;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;68;-1606.94,2106.61;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;67;-1607.94,2200.611;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-2273.432,927.2446;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;65;-1477.719,2134.175;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;37;-2402.433,836.2446;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-2270.432,1161.245;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-2134.432,836.2446;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;49;-2135.432,1137.245;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;47;-1945.345,786.8981;Inherit;False;Property;_MaskTexSTPattern;MaskTex ST Pattern;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;3;OnlyST;FlowbyTime;CustomDataXY;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;81;-892.4246,2128.574;Inherit;False;Property;_DistortChannel;Distort Channel;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;R;G;B;A;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-850.202,2313.438;Inherit;False;Property;_DistortStrength;Distort Strength;17;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;44;-1691.731,792.6719;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-631.4225,2132.999;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;45;-1556.731,865.6719;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;84;-384.9669,2129.047;Inherit;False;DistortOutput;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;46;-1555.731,771.6719;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;125;162.6582,963.8242;Inherit;False;3152.523;796.2561;Comment;12;108;176;179;180;181;185;186;183;193;195;196;290;Vertex Offset;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;63;-1235.422,1429.48;Inherit;False;944.8007;245.5021;Comment;5;60;57;58;59;61;Depth Setting;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;183;199.7282,1196.218;Inherit;False;Property;_OffsetTex_ST;OffsetTex_ST;32;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;85;-2348.563,-36.48888;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-796.3055,1023.708;Inherit;False;Property;_MaskPower;Mask Power;10;0;Create;True;0;0;0;False;0;False;1;0.88;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;52;-841.7036,794.3155;Inherit;False;Property;_MaskChannel;Mask Channel;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;R;G;B;A;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;185;448.9094,1191.77;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1185.422,1520.582;Inherit;False;Property;_DepthFade;DepthFade;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-874.2943,1777.675;Inherit;False;Property;_CameraFadeLength;Camera Fade Length;28;0;Create;True;0;0;0;False;0;False;1;1;0.5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;76;-611.2301,918.9399;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;176;591.9873,1060.108;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;57;-987.4207,1502.582;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-794.8922,1102.86;Inherit;False;Property;_MaskMultiply;Mask Multiply;11;0;Create;True;0;0;0;False;0;False;1;3.19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;94;-1049.154,1702.146;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;93;-830.1538,1881.146;Inherit;False;Property;_CameraFadeOffset;Camera Fade Offset;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;186;448.9094,1284.77;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-491.02,1895.814;Inherit;False;Constant;_Float2;Float 2;24;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-720.2469,1479.48;Inherit;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CameraDepthFade;91;-524.3878,1698.437;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-768.1708,718.1826;Inherit;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;61;-714.4205,1564.582;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;181;834.9092,1059.77;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-458.5784,918.9397;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;179;1033.909,1030.77;Inherit;True;Property;_OffsetTexture;Offset Texture;31;2;[NoScaleOffset];[SingleLineTexture];Create;True;1;Vertex Offset Setting;0;0;False;0;False;-1;None;33f4fe70796aee34eb18113883847d3c;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;98;-262.7446,1755.967;Inherit;False;Property;_UseCameraDepth;Use Camera Depth;27;0;Create;True;0;0;0;False;1;Header(CameraFade Setting);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-493.1349,582.2267;Inherit;False;Property;_FinalAlphaDeepen;Final Alpha Deepen;20;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;9;-1884.564,379.5109;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-211.4954,427.4131;Inherit;False;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;196;1396.486,1043.034;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.5;False;4;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;193;1161.744,1393.732;Inherit;False;Property;_AxisStrength;Axis Strength;33;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;1475.744,1206.732;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;195;1664.274,1298.88;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;180;1148.81,1230.996;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;3;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;5;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;4;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.ColorNode;213;-761.6348,-464.505;Inherit;False;Property;_FrontColor;FrontColor;57;2;[HDR];[Header];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;214;-762.6348,-299.505;Inherit;False;Property;_BackColor;BackColor;58;2;[HDR];[Header];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwitchByFaceNode;212;-512.6348,-376.505;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;36;-1163.616,770.3696;Inherit;True;Property;_MaskTexture;Mask Texture;5;3;[Header];[NoScaleOffset];[SingleLineTexture];Create;True;1;Mask;0;0;False;1;Space(10);False;-1;None;d56c9692570194f428389f6642045524;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;64;-1202.832,2105.3;Inherit;True;Property;_DistortTexture;Distort Texture;14;3;[Header];[NoScaleOffset];[SingleLineTexture];Create;True;1;Distort;0;0;False;1;Space(10);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;59;-551.4204,1499.582;Inherit;False;Property;_UseDepthFade;Use Depth Fade;25;0;Create;True;0;0;0;False;2;Header(Depth Fade);Space(5);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;108;1804.874,1270.525;Inherit;False;Property;_UseVertexOffset;Use Vertex Offset;30;0;Create;True;0;0;0;False;2;Header(Vertex Offset Setting);Space(5);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;211;-2236.563,-36.48888;Inherit;False;Property;_UseFlipbook;Use Flipbook;34;0;Create;True;0;0;0;False;2;Header(Flipbook Setting);Space(5);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;215;-290.6895,-400.2531;Inherit;False;Property;_DoubleFaceColor;Double Face Color;56;0;Create;True;0;0;0;False;1;Header(Open Double Face Setting);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;216;-483.5269,-459.6814;Inherit;False;Constant;_Float3;Float 3;37;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;-302.4949,-278.3324;Inherit;False;Property;_MainColor;MainColor;2;2;[HDR];[Header];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;221;-306.2787,-107.8548;Inherit;False;Property;_FresnelColor;Fresnel Color;39;2;[HDR];[Header];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;222;57.72131,-131.8548;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;224;-270.2787,69.1452;Inherit;False;223;Fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;55;-61.16455,427.4338;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;229;92.49268,403.2146;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;226;1518.245,-834.394;Inherit;False;Property;_InverseRange;Inverse Range;42;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;223;1846.245,-833.394;Inherit;False;Fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;227;1354.245,-810.394;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-1397.51,794.2359;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;235;-220.6361,1137.635;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;240;-453.4413,1066.322;Inherit;False;Property;_MaskAdd;Mask Add;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;237;-512.4587,1143.846;Inherit;False;2;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;225;1175.245,-835.394;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;220;467.2454,-721.394;Inherit;False;Property;_FresnelPower;Fresnel Power;41;0;Create;True;0;0;0;False;0;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;219;468.2454,-791.394;Inherit;False;Property;_FresnelScale;Fresnel Scale;40;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;217;721.1181,-834.9055;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;241;983.6777,-737.0568;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;239;-267.4413,991.3215;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;242;-86.80206,1005.651;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;243;-87.80206,1095.651;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;247;-1131.436,3462.399;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;244;-1437.436,3436.399;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;248;-1130.436,3549.399;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;251;-1438.436,3816.399;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;253;-1131.436,3841.399;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;254;-1131.436,3939.399;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;255;-877.4361,3704.399;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;256;-877.4361,3925.399;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;257;-624.4362,3925.399;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;-283.4365,3929.399;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;263;-494.4364,4275.4;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;258;-278.4365,3706.399;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;265;-12.43639,3915.399;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;264;-13.06261,3781.769;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;266;165.5636,3677.399;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;267;170.5636,3915.399;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;249;-878.4361,3489.399;Inherit;True;Property;_InverseExternelAlphaRange1;Inverse Externel Alpha Range;46;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;246;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;250;849.5643,3677.399;Inherit;True;Property;_Direction1;Direction;44;0;Create;True;0;0;0;False;0;False;0;1;1;True;;KeywordEnum;2;Vertical;Horizontal;Reference;245;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;269;391.7977,3816.219;Inherit;False;Property;_InverseExternelAlphaRange3;Inverse Externel Alpha Range;46;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;246;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;246;-883.636,3271.599;Inherit;True;Property;_InverseExternelAlphaRange;Inverse Externel Alpha Range;46;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;245;-1742.506,3941.471;Inherit;True;Property;_Direction;Direction;44;0;Create;True;0;0;0;False;0;False;0;1;1;True;;KeywordEnum;2;Vertical;Horizontal;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;274;-1933.469,3873.946;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;273;-1932.469,3976.456;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;278;930.2292,3314.239;Inherit;False;Constant;_Float5;Float 5;52;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;268;385.1986,3658.319;Inherit;False;Property;_InverseExternelAlphaRange2;Inverse Externel Alpha Range;46;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;246;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;275;-2485.633,3950.394;Inherit;False;Property;_ExternelAlphaValue;Externel Alpha Value;47;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;272;-2485.176,4026.518;Inherit;False;2;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;102;384.4824,670.3606;Inherit;False;Property;_Step;Step;23;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;232;378.1907,765.0731;Inherit;False;Property;_Softness;Softness;24;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;100;837.4824,617.3606;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;230;807.1907,736.0731;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;231;978.1907,666.0731;Inherit;False;Property;_StepOption;Step Option;22;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;Step;Smoothstep;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;233;681.1907,745.0731;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;285;590.168,322.3103;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;286;328.168,321.3103;Inherit;False;283;Externel Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;101;1331.482,318.3606;Inherit;False;Property;_AlphaUseStep;Alpha Use Step;21;0;Create;True;0;0;0;False;2;Header(Alpha Step);Space(5);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;289;1583.826,434.009;Inherit;False;Constant;_Float4;Float 4;55;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;290;2158.958,1267.31;Inherit;False;Vertex Offset Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;291;2553.223,-7.354919;Inherit;False;290;Vertex Offset Output;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;287;2350.722,322.4539;Inherit;False;Property;_ExternelAlphaChecker;Externel Alpha Checker;50;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;281;-2193.522,3946.624;Inherit;False;Property;_ControlMethod;Control Method;45;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;Const;CustomData2w;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;270;1183.347,3315.506;Inherit;False;Property;_ExternalAlphaOption;External Alpha Option;43;0;Create;True;0;0;0;False;1;Header(External Alpha Templete);False;0;0;0;True;;KeywordEnum;3;Disable;Line;Gradient;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;283;1713.693,3313.49;Inherit;False;Externel Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;293;1516.239,3313.663;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;252;-622.4362,3707.399;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;261;-939.6358,4161.98;Inherit;False;Property;_ExternelAlphaRangePower;Externel Alpha Range Power;48;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;262;-938.5928,4298.4;Inherit;False;Property;_ExternelAlphaRangeMultiply;Externel Alpha Range Multiply;49;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;276;-13.7175,3338.004;Inherit;True;Property;_Direction2;Direction;44;0;Create;True;0;0;0;False;0;False;0;1;1;True;;KeywordEnum;2;Vertical;Horizontal;Reference;245;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;294;-258.0853,3291.043;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;297;-241.0641,3457.003;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;295;-476.2938,3283.462;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;296;-468.7124,3479.861;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;527.8201,-95.79272;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;288;1874.533,74.39182;Inherit;False;283;Externel Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;310;2341.943,-512.951;Inherit;False;Property;_BlendMode;Blend Mode;75;1;[Enum];Create;True;0;2;Additive;1;Alpha;10;0;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;312;2341.863,-290.2994;Inherit;False;Property;_ZTestSetting;ZTest Setting;76;1;[Enum];Create;True;0;9;Always;0;Never;1;Less;2;Equal;3;LEqual;4;Greater;5;NotEqual;6;GEqual;7;Always;8;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;33;-486.5564,148.7777;Inherit;False;Property;_AlphaChannel;Alpha Channel;19;0;Create;True;0;0;0;False;2;Header(Alpha Setting);Space(5);False;0;3;3;True;;KeywordEnum;4;R;G;B;A;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;2345.133,-593.2218;Inherit;False;Property;_CullMode;Cull Mode;74;2;[Header];[Enum];Create;True;1;Other Setting;1;Option1;0;1;UnityEngine.Rendering.CullMode;True;1;Space(5);False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;300;716.0778,-228.496;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;302;879.8864,-228.3054;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;306;1260.982,-228.9756;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;307;943.9819,-147.9756;Inherit;False;Property;_GrayScaleOffset;GrayScale Offset;54;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;301;1037.886,-228.3054;Inherit;False;1;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;304;1563.49,-430.619;Inherit;False;Property;_ColorRampEmission;Color Ramp Emission;53;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;303;1792.49,-383.619;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;308;1363.07,-231.5205;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;299;1506.532,-333.0465;Inherit;True;Property;_ColorRamp;Color Ramp;52;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerStateNode;309;1243.919,-54.52861;Inherit;False;1;1;1;1;-1;None;1;0;SAMPLER2D;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.TexturePropertyNode;372;-2240.824,100.9222;Inherit;True;Property;_MainTex;MainTex;0;1;[Header];Create;True;1;MainTex;0;0;False;1;Space(10);False;None;a08b7a0d140e70540bf26d5478c11d8d;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;422;2656.565,-170.7552;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2;3005.874,-115.2932;Half;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;To7/ParticleAlpha;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;7;True;12;all;0;True;True;2;5;False;;10;True;_BlendMode;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;True;True;2;True;_ZWriteSet;True;3;True;_ZTestSetting;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;False;0;Hidden/InternalErrorShader;0;0;Standard;22;Surface;1;637871831662488076;  Blend;0;0;Two Sided;1;0;Cast Shadows;0;637871831758211704;  Use Shadow Threshold;0;0;Receive Shadows;0;637871831745536286;GPU Instancing;1;0;LOD CrossFade;0;0;Built-in Fog;0;0;DOTS Instancing;0;0;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;638220801052131883;  Phong;1;638220800640417791;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position,InvertActionOnDeselection;1;638220795036905547;0;5;False;True;False;True;False;False;;True;0
Node;AmplifyShaderEditor.SamplerNode;373;-1987.825,-44.07785;Inherit;True;Property;_TextureSample3;Texture Sample 3;68;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;21;-3517.958,187.5111;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;19;-3485.958,91.51108;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-3357.958,91.51108;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;374;-1986.421,155.1391;Inherit;False;MainTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;446;-2665.189,-706.8004;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;447;-2637.189,-877.8004;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;444;-2361.189,-877.8004;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;449;-2307.585,-667.1716;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;450;-2104.585,-878.1716;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;451;-2170.585,-977.1716;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;452;-1928.585,-937.1716;Inherit;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;453;-1694.713,-937.5193;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;457;-3007.105,-1014.104;Inherit;False;Property;_UseParallax;Use Parallax;66;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;370;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;454;-1891.135,-692.978;Inherit;False;Property;_LightStrength;Light Strength;60;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;464;-1706.867,-682.821;Inherit;False;SRP Additional Light;-1;;11;6c86746ad131a0a408ca599df5f40861;7,6,0,9,0,23,0,27,0,25,0,24,0,26,0;6;2;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;15;FLOAT3;0,0,0;False;14;FLOAT3;1,1,1;False;18;FLOAT;0.5;False;32;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;465;-1452.867,-759.821;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;459;-3763.725,-818.989;Inherit;False;Property;_NormalStrength;Normal Strength;62;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;466;-3517.512,-644.1953;Inherit;False;Normal Strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;458;-3549.108,-993.3479;Inherit;False;456;Parallax Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;448;-3365.507,-869.3331;Inherit;True;Property;_NormalMap;Normal Map;61;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;469;-3039.149,-803.0323;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;462;-1003.207,-369.2302;Inherit;False;HardLight;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;479;-5663.367,-318.3373;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;486;-5848.487,-302.5236;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;487;-5850.487,-208.5236;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;482;-6061.487,-313.5236;Inherit;False;Property;_NoiseUV;NoiseUV;65;0;Create;True;0;0;0;False;0;False;3,3,0,0;3,3,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;477;-5361.566,-320.3374;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;474;-5029.768,-115.9374;Inherit;False;Simple;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;473;-5029.768,-215.9374;Inherit;False;Gradient;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;471;-5031.203,-319.2916;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;489;-4964.31,-397.1389;Inherit;False;Constant;_Float6;Float 6;71;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;201;-3686.144,435.4971;Inherit;False;Property;_FlipbookColumnsRowsSpeedStartFrame;Flipbook Columns / Rows / Speed / StartFrame;36;0;Create;True;1;Flipbook Setting;0;0;False;0;False;4,4,9,0;4,4,9,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-3749.056,239.5754;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;24;-3451.453,309.6291;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-3209.979,209.9943;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCFlipBookUVAnimation;197;-2519.197,332.0268;Inherit;False;0;0;6;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;31;-2716.39,27.51111;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-2716.39,-52.48888;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-2604.391,139.5111;Inherit;False;84;DistortOutput;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-2588.391,-36.48888;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;28;-2844.39,-52.48888;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StaticSwitch;202;-2819.232,510.039;Inherit;False;Property;_FlipbookMode;Flipbook Mode;35;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;Constant;Speed;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;204;-2976.994,303.2691;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;200;-3252.138,368.1357;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;491;-4152.861,-346.5476;Inherit;False;NoiseUV;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;499;-4711.094,-321.6419;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;500;-4710.193,-226.7051;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;488;-4417.419,-347.3868;Inherit;True;Property;_FlowNoise;FlowNoise;63;0;Create;True;0;0;0;False;2;Header(Flow Noise);Space(10);False;0;0;0;True;;KeywordEnum;4;Disable;Simplex2D;Gradient;Simple;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;501;-4710.193,-132.7051;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;502;-4963.193,-6.705139;Inherit;False;Property;_NoiseStrength;Noise Strength;64;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;511;-1335.383,-166.9074;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;371;-1152.038,99.11667;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;513;-1151.334,-55.87961;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StaticSwitch;236;-84.92529,841.7441;Inherit;False;Property;_MaskUseFrom1to0Dissolve;Mask Use From 1 to 0 Dissolve;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;3;Disable;Const;CustomData2Z;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;53;-168.8513,718.1423;Inherit;False;Property;_MaskAffectAlpha;Mask Affect Alpha ?;9;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;228;284.4927,426.2146;Inherit;False;Property;_ImpactAlpha;Impact Alpha;38;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Disable;Color;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;463;-563.4177,-133.8032;Inherit;False;Property;_UseLight;Use Light;59;0;Create;True;0;0;0;False;2;Header(Light Setting);Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;32;-886.5869,-117.7865;Inherit;False;Property;_MainTexChannel;MainTex Channel;4;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;5;RGB;R;G;B;A;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;218;291.8411,-274.7129;Inherit;False;Property;_ImpactColor;Impact Color;37;0;Create;True;0;0;0;False;2;Header(Fresnel Setting);Space(10);False;0;0;0;True;;Toggle;2;Disable;Color;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;292;2221.689,-115.0735;Inherit;False;Property;_ExternelAlphaChecker1;Externel Alpha Checker;50;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;287;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;305;1796.988,-111.5748;Inherit;False;Property;_UseColorRamp;Use Color Ramp;51;0;Create;True;0;0;0;False;2;Header(Color Ramp Setting);Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;515;1864.741,-225.1325;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;516;1587.661,-613.097;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;514;2050.142,-287.1163;Inherit;False;Property;_RampMultiplyVertexColor;Ramp Multiply Vertex Color;55;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;541;-2791.184,-215.1463;Inherit;False;MainTex_ST;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;74;-1996.555,2121.837;Inherit;False;Property;_DistortTexSTPattern;DistortTex ST Pattern;16;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;3;OnlyST;FlowbyTime;CustomWT;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;206;-2144.791,2393.421;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;205;-2690.959,2446.285;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;208;-2426.791,2518.421;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;207;-2318.791,2393.421;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;73;-2453.643,2262.183;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;549;-2048.784,2509.748;Inherit;False;Property;_Keyword0;Keyword 0;71;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;546;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;518;-1796.349,5905.257;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;519;-1728.854,6255.568;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;520;-1676.746,6443.529;Inherit;False;Constant;_Float7;Float 0;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;521;-1782.904,5584.625;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;538;-708.4578,5838.187;Inherit;False;374;MainTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;540;-1323.329,5222.356;Inherit;True;Property;_TextureSample2;Texture Sample 2;78;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;539;-785.0423,5244.85;Inherit;False;Normal From Height;-1;;15;1942fe2c5f1a1f94881a33d532e4afeb;0;2;20;FLOAT;0;False;110;FLOAT;1;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;467;-1162.432,5055.037;Inherit;False;466;Normal Strength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;468;-433.2239,5229.884;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;456;-202.5159,5206.968;Inherit;False;Parallax Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;440;-94.31052,5682.892;Inherit;False;Parallax Mapping;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;548;-1942.099,5902.325;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;543;-2542.228,6075.447;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;378;-1953.293,230.7811;Inherit;False;440;Parallax Mapping;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;530;-1800.75,5222.988;Inherit;True;Property;_HeightMap1;HeightMap;67;0;Create;True;1;Black is No ParallaxWhite is Parallax Strength;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;531;-1792.75,5421.988;Inherit;True;Property;_HeightMapNoise;HeightMapNoise;69;0;Create;True;1;Mask For HeightMap;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;523;-440.8066,5686.771;Inherit;True;Property;_MainTex1;MainTex;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;546;-2288.592,5897.792;Inherit;False;Property;_ParallaxStrengthControlMethod;Parallax Strength Control Method;71;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;Const;CustomData2X;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;547;-2549.099,5898.325;Inherit;False;Property;_ParallaxStrength;Parallax Strength;72;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerStateNode;517;-1843.749,5683.988;Inherit;False;0;0;0;1;-1;None;1;0;SAMPLER2D;;False;1;SAMPLERSTATE;0
Node;AmplifyShaderEditor.RangedFloatNode;532;-1801.349,5814.257;Inherit;False;Property;_SampleSteps;SampleSteps;73;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;542;-1031.81,6243.852;Inherit;False;541;MainTex_ST;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;551;-1071.841,5977.932;Inherit;False;Constant;_Vector2;Vector 2;77;0;Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;552;-1654.2,6077.916;Inherit;False;Constant;_Vector3;Vector 3;77;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;525;-1369.705,5971.529;Inherit;False;Property;_HeightMapNoise_ST;HeightMapNoise_ST;70;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;522;-2737.706,5668.529;Inherit;False;Property;_HeightMap_ST;HeightMap_ST;68;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;17;-3725.958,-52.48888;Inherit;False;Property;_MainTexST;MainTex ST;1;0;Create;True;0;0;0;False;0;False;1,1,0,0;2,1,1.65,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;18;-3485.958,11.51112;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;23;-3245.958,-4.488889;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;15;-3085.958,-52.48888;Inherit;False;Property;_MainTexSTPattern;MainTex ST Pattern;3;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;3;OnlyST;FlowbyTime;CustomDataXY;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;512;-1628.637,-254.3419;Inherit;False;491;NoiseUV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;370;-1689.565,-43.48888;Inherit;False;Property;_UseParallax;Use Parallax;66;0;Create;True;0;0;0;False;3;Header(Parallax Setting,CustomVertex Streams Need TANGENT);Space(10);;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;536;-836.2141,5444.62;Inherit;False;half HeightValue = SAMPLE_TEXTURE2D(_HeightMap, linear_repeat_sampler, TRANSFORM_TEX(uv.xy, _HeightMap)).r@$								//half HeightValue = tex2D(_HeightMap , TRANSFORM_TEX(uv.xy, _HeightMap))@$								                    //const int minLayers = 32@$								                    //const int maxLayers = 64@$								                    //float viewDirOptimize = max(abs(dot(float3(0,0,1),normalize(o.ViewDir))),0) * maxLayers@$								                    float numLayers = _HeightSampleSteps@$								                    float layerDepth = 1 / numLayers@$								                    float currentLayerDepth = 0@$								                    float2 P = ViewDir.xy * customData2.z / pos.w@ //(opration: pos.w可以減少因鏡頭距離太遠而產生過高的偏移)$								                    float2 deltaTexCoords = P / numLayers@$								                    float2 currentTexCoords = uv.xy@$								                    float currentDepthMapValue = HeightValue@$								                    half HeightMapNoise = SAMPLE_TEXTURE2D(_HeightMapNoise, linear_repeat_sampler, TRANSFORM_TEX(uv.xy , _HeightMapNoise))[$								                        _HeightMapNoiseChannel]@$													//half HeightMapNoise = tex2D(_HeightMapNoise, TRANSFORM_TEX(uv.xy , _HeightMapNoise)).r@	$								                    [loop]$								                    while (currentLayerDepth < currentDepthMapValue) {$								                        currentTexCoords -= deltaTexCoords * HeightMapNoise@$								                        currentDepthMapValue = SAMPLE_TEXTURE2D_LOD(_HeightMap, linear_repeat_sampler, TRANSFORM_TEX(currentTexCoords, _HeightMap), 0).r@$														//currentDepthMapValue = tex2Dlod(_HeightMap , float4(TRANSFORM_TEX(currentTexCoords, _HeightMap) , 0 , 0)).r@$								                        currentLayerDepth += layerDepth@$								                    }$								                    /*註記:由於下面的計算方式類似RayMarching的遞進式，且會拿當前的值與HeightMap值做對比再決定是否繼續往下跑，因此Unroll(一次性展開所有計算方式)並不划算。$								                    GPU的if-statement並不會跳過fail情況的計算，而是先進行計算在取決於當前條件是否成功。因此根據當前情況進行loop跳轉會比較合適。$								                    [unroll(32)]$								                    while(currentLayerDepth<currentDepthMapValue){$								                        currentTexCoords -= deltaTexCoords@$								                        currentDepthMapValue = tex2D(_HeightMap,currentTexCoords).r@$								                        currentLayerDepth += layerDepth@$								                    }$								註記:如果不使用Unroll則會報錯,主要原因為tex2D並不能在loop標籤下執行。因為GPU是以每四個像素一次進行著色，而fragment需要透過像素之間的UV差距來判斷$								要使用的mipmaps。而動態分支對於不同的像素計算方式無法確定，所以禁止使用tex2D。$								但可以透過tex2Dlod或tex2DGrad直接指定mipmap等級，否則就需要宣告unroll標籤。*/$								                    float2 preTexCoords = currentTexCoords + deltaTexCoords@$								                    float beforeDepth = SAMPLE_TEXTURE2D(_HeightMap, linear_repeat_sampler, TRANSFORM_TEX(preTexCoords,_HeightMap)).r - currentLayerDepth + layerDepth@$													//float beforeDepth = tex2D(_HeightMap , TRANSFORM_TEX(preTexCoords,_HeightMap)).r - currentLayerDepth + layerDepth@$								                    float afterDepth = currentDepthMapValue - currentLayerDepth@$								                    float weight = afterDepth / (afterDepth - beforeDepth)@$								                    float2 finalTexCoords = preTexCoords * weight + currentTexCoords * (1 - weight)@$								                    //if( finalTexCoords.x>1 || finalTexCoords.y>1 || finalTexCoords.x<0 || finalTexCoords.y<0 )$								                    //   discard@$								                    MainTexUV = TRANSFORM_TEX(finalTexCoords, _MainTex)@$								                    uv.xy = finalTexCoords@$								return MainTexUV@;2;Create;13;True;_HeightMap;SAMPLER2D;0;In;;Inherit;False;True;_HeightMapNoise;SAMPLER2D;;In;;Inherit;False;True;linear_repeat_sampler;SAMPLERSTATE;0;In;;Inherit;False;True;_HeightSampleSteps;FLOAT;0;In;;Inherit;False;True;ViewDir;FLOAT3;0,0,0;In;;Inherit;False;True;customData2;FLOAT4;0,0,0,0;In;;Inherit;False;True;pos;FLOAT4;0,0,0,0;In;;Inherit;False;True;_HeightMapNoiseChannel;INT;0;In;;Inherit;False;True;uv;FLOAT2;0,0;InOut;;Inherit;False;True;_HeightMap_ST;FLOAT4;0,0,0,0;In;;Inherit;False;True;_HeightMapNoise_ST;FLOAT4;0,0,0,0;In;;Inherit;False;True;MainTexUV;FLOAT2;0,0;In;;Inherit;False;True;_MainTex_ST;FLOAT4;0,0,0,0;In;;Inherit;False;Parallax;True;False;0;;False;13;0;SAMPLER2D;0;False;1;SAMPLER2D;;False;2;SAMPLERSTATE;0;False;3;FLOAT;0;False;4;FLOAT3;0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;INT;0;False;8;FLOAT2;0,0;False;9;FLOAT4;0,0,0,0;False;10;FLOAT4;0,0,0,0;False;11;FLOAT2;0,0;False;12;FLOAT4;0,0,0,0;False;2;FLOAT2;0;FLOAT2;9
Node;AmplifyShaderEditor.RangedFloatNode;554;-2260.851,6775.297;Inherit;False;Property;_ZWriteSet;ZWrite Set;77;1;[Enum];Create;True;0;2;Off;0;On;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
WireConnection;70;0;73;0
WireConnection;70;1;72;0
WireConnection;69;0;75;1
WireConnection;69;1;75;2
WireConnection;71;0;69;0
WireConnection;71;2;70;0
WireConnection;66;0;74;0
WireConnection;41;0;50;3
WireConnection;41;1;50;4
WireConnection;68;0;66;0
WireConnection;68;1;66;1
WireConnection;67;0;66;2
WireConnection;67;1;66;3
WireConnection;38;0;41;0
WireConnection;38;1;40;0
WireConnection;65;0;68;0
WireConnection;65;1;67;0
WireConnection;37;0;50;1
WireConnection;37;1;50;2
WireConnection;42;0;48;1
WireConnection;42;1;48;2
WireConnection;39;0;37;0
WireConnection;39;2;38;0
WireConnection;49;0;37;0
WireConnection;49;2;42;0
WireConnection;47;1;50;0
WireConnection;47;0;39;0
WireConnection;47;2;49;0
WireConnection;81;1;64;1
WireConnection;81;0;64;2
WireConnection;81;2;64;3
WireConnection;81;3;64;4
WireConnection;44;0;47;0
WireConnection;80;0;81;0
WireConnection;80;1;83;0
WireConnection;45;0;44;2
WireConnection;45;1;44;3
WireConnection;84;0;80;0
WireConnection;46;0;44;0
WireConnection;46;1;44;1
WireConnection;85;0;11;0
WireConnection;85;1;87;0
WireConnection;52;1;36;1
WireConnection;52;0;36;2
WireConnection;52;2;36;3
WireConnection;52;3;36;4
WireConnection;185;0;183;1
WireConnection;185;1;183;2
WireConnection;76;0;52;0
WireConnection;76;1;78;0
WireConnection;176;0;185;0
WireConnection;57;0;58;0
WireConnection;186;0;183;3
WireConnection;186;1;183;4
WireConnection;91;2;94;0
WireConnection;91;0;97;0
WireConnection;91;1;93;0
WireConnection;61;0;57;0
WireConnection;181;0;176;0
WireConnection;181;2;186;0
WireConnection;77;0;76;0
WireConnection;77;1;79;0
WireConnection;179;1;181;0
WireConnection;98;1;99;0
WireConnection;98;0;91;0
WireConnection;10;0;33;0
WireConnection;10;1;9;4
WireConnection;10;2;53;0
WireConnection;10;3;59;0
WireConnection;10;4;90;0
WireConnection;10;5;98;0
WireConnection;196;0;179;1
WireConnection;194;0;196;0
WireConnection;194;1;193;0
WireConnection;195;0;194;0
WireConnection;212;0;213;0
WireConnection;212;1;214;0
WireConnection;36;1;43;0
WireConnection;64;1;65;0
WireConnection;59;1;60;0
WireConnection;59;0;61;0
WireConnection;108;0;195;0
WireConnection;211;1;85;0
WireConnection;211;0;197;0
WireConnection;215;1;216;0
WireConnection;215;0;212;0
WireConnection;222;0;7;0
WireConnection;222;1;221;0
WireConnection;222;2;224;0
WireConnection;55;0;10;0
WireConnection;229;0;224;0
WireConnection;229;1;55;0
WireConnection;226;1;225;0
WireConnection;226;0;227;0
WireConnection;223;0;226;0
WireConnection;227;0;225;0
WireConnection;43;0;46;0
WireConnection;43;1;45;0
WireConnection;235;0;77;0
WireConnection;235;1;237;1
WireConnection;225;0;241;0
WireConnection;217;2;219;0
WireConnection;217;3;220;0
WireConnection;241;0;217;0
WireConnection;239;0;77;0
WireConnection;239;1;240;0
WireConnection;242;0;239;0
WireConnection;243;0;235;0
WireConnection;247;0;244;1
WireConnection;244;1;245;0
WireConnection;248;0;244;2
WireConnection;251;1;245;0
WireConnection;253;0;251;1
WireConnection;254;0;251;2
WireConnection;255;0;251;1
WireConnection;255;1;253;0
WireConnection;256;0;251;2
WireConnection;256;1;254;0
WireConnection;257;0;256;0
WireConnection;257;1;261;0
WireConnection;260;0;257;0
WireConnection;260;1;263;0
WireConnection;263;0;261;0
WireConnection;263;1;262;0
WireConnection;258;0;252;0
WireConnection;258;1;263;0
WireConnection;265;0;260;0
WireConnection;264;0;258;0
WireConnection;266;0;264;0
WireConnection;267;0;265;0
WireConnection;249;1;244;2
WireConnection;249;0;248;0
WireConnection;250;1;269;0
WireConnection;250;0;268;0
WireConnection;269;1;265;0
WireConnection;269;0;267;0
WireConnection;246;1;244;1
WireConnection;246;0;247;0
WireConnection;245;1;274;0
WireConnection;245;0;273;0
WireConnection;274;1;281;0
WireConnection;273;0;281;0
WireConnection;268;1;264;0
WireConnection;268;0;266;0
WireConnection;100;0;102;0
WireConnection;100;1;285;0
WireConnection;230;0;285;0
WireConnection;230;1;102;0
WireConnection;230;2;233;0
WireConnection;231;1;100;0
WireConnection;231;0;230;0
WireConnection;233;0;102;0
WireConnection;233;1;232;0
WireConnection;285;0;286;0
WireConnection;285;1;228;0
WireConnection;101;1;285;0
WireConnection;101;0;231;0
WireConnection;290;0;108;0
WireConnection;287;1;101;0
WireConnection;287;0;289;0
WireConnection;281;1;275;0
WireConnection;281;0;272;2
WireConnection;270;1;278;0
WireConnection;270;0;276;0
WireConnection;270;2;250;0
WireConnection;283;0;293;0
WireConnection;293;0;270;0
WireConnection;252;0;255;0
WireConnection;252;1;261;0
WireConnection;276;1;297;0
WireConnection;276;0;294;0
WireConnection;294;0;295;0
WireConnection;294;1;263;0
WireConnection;297;0;296;0
WireConnection;297;1;263;0
WireConnection;295;0;246;0
WireConnection;295;1;261;0
WireConnection;296;0;249;0
WireConnection;296;1;261;0
WireConnection;8;0;218;0
WireConnection;8;1;463;0
WireConnection;8;2;236;0
WireConnection;8;3;215;0
WireConnection;8;4;9;0
WireConnection;33;1;371;0
WireConnection;33;0;371;1
WireConnection;33;2;371;2
WireConnection;33;3;371;3
WireConnection;300;0;8;0
WireConnection;300;1;101;0
WireConnection;302;0;300;0
WireConnection;306;0;301;0
WireConnection;306;1;307;0
WireConnection;301;0;302;0
WireConnection;303;0;304;0
WireConnection;303;1;299;0
WireConnection;308;0;306;0
WireConnection;299;1;308;0
WireConnection;299;7;309;0
WireConnection;2;2;292;0
WireConnection;2;3;287;0
WireConnection;2;5;291;0
WireConnection;373;0;372;0
WireConnection;373;1;211;0
WireConnection;19;0;17;3
WireConnection;19;1;17;4
WireConnection;22;0;19;0
WireConnection;22;1;21;0
WireConnection;374;0;372;0
WireConnection;447;0;457;0
WireConnection;444;0;447;0
WireConnection;444;1;446;0
WireConnection;450;0;444;0
WireConnection;450;1;449;0
WireConnection;452;0;451;0
WireConnection;452;1;450;0
WireConnection;452;2;449;2
WireConnection;453;0;452;0
WireConnection;453;1;454;0
WireConnection;457;1;469;0
WireConnection;457;0;458;0
WireConnection;465;0;453;0
WireConnection;465;1;464;0
WireConnection;466;0;459;0
WireConnection;448;1;211;0
WireConnection;448;5;459;0
WireConnection;469;0;448;0
WireConnection;462;0;32;0
WireConnection;462;1;465;0
WireConnection;479;0;486;0
WireConnection;486;0;482;1
WireConnection;486;1;482;2
WireConnection;487;0;482;3
WireConnection;487;1;482;4
WireConnection;477;0;479;0
WireConnection;477;2;487;0
WireConnection;474;0;477;0
WireConnection;473;0;477;0
WireConnection;471;0;477;0
WireConnection;24;0;12;3
WireConnection;24;1;12;4
WireConnection;25;0;18;0
WireConnection;25;2;24;0
WireConnection;197;0;85;0
WireConnection;197;1;201;1
WireConnection;197;2;201;2
WireConnection;197;3;202;0
WireConnection;197;4;201;4
WireConnection;197;5;200;0
WireConnection;31;0;28;2
WireConnection;31;1;28;3
WireConnection;29;0;28;0
WireConnection;29;1;28;1
WireConnection;11;0;29;0
WireConnection;11;1;31;0
WireConnection;28;0;15;0
WireConnection;202;1;204;0
WireConnection;202;0;201;3
WireConnection;204;0;201;3
WireConnection;204;1;200;0
WireConnection;491;0;488;0
WireConnection;499;0;471;0
WireConnection;499;1;502;0
WireConnection;500;0;473;0
WireConnection;500;1;502;0
WireConnection;488;1;489;0
WireConnection;488;0;499;0
WireConnection;488;2;500;0
WireConnection;488;3;501;0
WireConnection;501;0;474;0
WireConnection;501;1;502;0
WireConnection;511;0;370;0
WireConnection;511;1;512;0
WireConnection;371;0;370;0
WireConnection;513;0;511;0
WireConnection;236;1;77;0
WireConnection;236;0;242;0
WireConnection;236;2;243;0
WireConnection;53;1;54;0
WireConnection;53;0;236;0
WireConnection;228;1;55;0
WireConnection;228;0;229;0
WireConnection;463;1;32;0
WireConnection;463;0;462;0
WireConnection;32;1;511;0
WireConnection;32;0;513;0
WireConnection;32;2;513;1
WireConnection;32;3;513;2
WireConnection;32;4;513;3
WireConnection;218;1;7;0
WireConnection;218;0;222;0
WireConnection;292;1;514;0
WireConnection;292;0;288;0
WireConnection;305;1;8;0
WireConnection;305;0;303;0
WireConnection;515;0;516;0
WireConnection;515;1;305;0
WireConnection;514;1;305;0
WireConnection;514;0;515;0
WireConnection;541;0;15;0
WireConnection;74;1;75;0
WireConnection;74;0;71;0
WireConnection;74;2;549;0
WireConnection;206;0;207;0
WireConnection;206;2;208;0
WireConnection;208;0;205;3
WireConnection;208;1;205;4
WireConnection;207;0;75;1
WireConnection;207;1;75;2
WireConnection;73;0;75;3
WireConnection;73;1;75;4
WireConnection;549;1;206;0
WireConnection;549;0;75;0
WireConnection;540;0;530;0
WireConnection;539;20;540;1
WireConnection;539;110;467;0
WireConnection;468;0;539;0
WireConnection;456;0;468;0
WireConnection;440;0;523;0
WireConnection;548;2;546;0
WireConnection;523;0;538;0
WireConnection;523;1;536;9
WireConnection;546;1;547;0
WireConnection;546;0;543;3
WireConnection;18;0;17;1
WireConnection;18;1;17;2
WireConnection;23;0;18;0
WireConnection;23;2;22;0
WireConnection;15;1;17;0
WireConnection;15;0;23;0
WireConnection;15;2;25;0
WireConnection;370;1;373;0
WireConnection;370;0;378;0
WireConnection;536;0;530;0
WireConnection;536;1;531;0
WireConnection;536;2;517;0
WireConnection;536;3;532;0
WireConnection;536;4;518;0
WireConnection;536;5;548;0
WireConnection;536;6;519;0
WireConnection;536;7;520;0
WireConnection;536;8;521;0
WireConnection;536;9;522;0
WireConnection;536;10;525;0
WireConnection;536;11;521;0
WireConnection;536;12;542;0
ASEEND*/
//CHKSM=0A71985488A395BE5F6A2D69390D542117BFB1EA