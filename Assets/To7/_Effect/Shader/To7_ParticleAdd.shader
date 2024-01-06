// Made with Amplify Shader Editor v1.9.2.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "To7/ParticleAdd"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Header(MainTex)]_MainTex("MainTex", 2D) = "white" {}
		_MainTexST("MainTex ST", Vector) = (1,1,0,0)
		[HDR]_MainColor("MainColor", Color) = (1,1,1,1)
		[KeywordEnum(OnlyST,FlowbyTime,CustomDataXY)] _MainTexSTPattern("MainTex ST Pattern", Float) = 0
		[KeywordEnum(RGB,R,G,B,A)] _MainTexChannel("MainTex Channel", Float) = 0
		[Header(Mask)]_MaskTexture("Mask Texture", 2D) = "white" {}
		_MaskTexST("MaskTex ST", Vector) = (1,1,0,0)
		[KeywordEnum(OnlyST,FlowbyTime,CustomDataXY)] _MaskTexSTPattern("MaskTex ST Pattern", Float) = 0
		[KeywordEnum(R,G,B,A)] _MaskChannel("Mask Channel", Float) = 0
		[Toggle(_MASKAFFECTALPHA_ON)] _MaskAffectAlpha("Mask Affect Alpha ?", Float) = 1
		_MaskPower("Mask Power", Float) = 1
		_MaskMultiply("Mask Multiply", Float) = 1
		[Header(Distort)]_DistortTexture("Distort Texture", 2D) = "white" {}
		_DistortTexST("DistortTex ST", Vector) = (1,1,0,0)
		[KeywordEnum(OnlyST,FlowbyTime)] _DistortTexSTPattern("DistortTex ST Pattern", Float) = 0
		_DistortStrength("Distort Strength", Float) = 0
		[KeywordEnum(R,G,B,A)] _DistortChannel("Distort Channel", Float) = 0
		[Header(Other Setting)][Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Float) = 2
		[KeywordEnum(R,G,B,A)] _AlphaChannel("Alpha Channel", Float) = 3
		_FinalAlphaDeepen("Final Alpha Deepen", Float) = 1
		[Toggle(_USEDEPTHFADE_ON)] _UseDepthFade("Use Depth Fade", Float) = 0
		_DepthFade("DepthFade", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_ZWrite("ZWrite", Float) = 1

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
		#pragma target 2.0

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
			
			Blend One One, One OneMinusSrcAlpha
			ZWrite [_ZWrite]
			ZTest [_ZTest]
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			
			#pragma multi_compile_instancing
			#define _RECEIVE_SHADOWS_OFF 1
			#define ASE_SRP_VERSION -1
			#define REQUIRE_DEPTH_TEXTURE 1

			
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

			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _MAINTEXCHANNEL_RGB _MAINTEXCHANNEL_R _MAINTEXCHANNEL_G _MAINTEXCHANNEL_B _MAINTEXCHANNEL_A
			#pragma shader_feature_local _MAINTEXSTPATTERN_ONLYST _MAINTEXSTPATTERN_FLOWBYTIME _MAINTEXSTPATTERN_CUSTOMDATAXY
			#pragma shader_feature_local _DISTORTCHANNEL_R _DISTORTCHANNEL_G _DISTORTCHANNEL_B _DISTORTCHANNEL_A
			#pragma shader_feature_local _DISTORTTEXSTPATTERN_ONLYST _DISTORTTEXSTPATTERN_FLOWBYTIME
			#pragma shader_feature_local _MASKCHANNEL_R _MASKCHANNEL_G _MASKCHANNEL_B _MASKCHANNEL_A
			#pragma shader_feature_local _MASKTEXSTPATTERN_ONLYST _MASKTEXSTPATTERN_FLOWBYTIME _MASKTEXSTPATTERN_CUSTOMDATAXY
			#pragma shader_feature_local _USEDEPTHFADE_ON
			#pragma shader_feature_local _ALPHACHANNEL_R _ALPHACHANNEL_G _ALPHACHANNEL_B _ALPHACHANNEL_A
			#pragma shader_feature_local _MASKAFFECTALPHA_ON


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				half4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
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
				float4 ase_color : COLOR;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainColor;
			half4 _MainTexST;
			half4 _DistortTexST;
			half4 _MaskTexST;
			half _CullMode;
			half _ZWrite;
			half _DistortStrength;
			half _MaskPower;
			half _MaskMultiply;
			half _DepthFade;
			half _FinalAlphaDeepen;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			sampler2D _DistortTexture;
			sampler2D _MaskTexture;
			uniform float4 _CameraDepthTexture_TexelSize;


						
			VertexOutput VertexFunction ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 ase_clipPos = TransformObjectToHClip((v.vertex).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord5 = screenPos;
				
				o.ase_texcoord3 = v.ase_texcoord;
				o.ase_color = v.ase_color;
				o.ase_texcoord4 = v.ase_texcoord1;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
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
				half4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;

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
				o.ase_color = v.ase_color;
				o.ase_texcoord1 = v.ase_texcoord1;
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
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
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

			half4 frag ( VertexOutput IN  ) : SV_Target
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
				half2 appendResult18 = (half2(_MainTexST.x , _MainTexST.y));
				half2 appendResult19 = (half2(_MainTexST.z , _MainTexST.w));
				half4 appendResult23 = (half4(appendResult18 , ( appendResult19 * _TimeParameters.x )));
				half4 texCoord12 = IN.ase_texcoord3;
				texCoord12.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
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
				half2 texCoord11 = IN.ase_texcoord3.xy * appendResult29 + appendResult31;
				half2 appendResult69 = (half2(_DistortTexST.x , _DistortTexST.y));
				half2 appendResult73 = (half2(_DistortTexST.z , _DistortTexST.w));
				half4 appendResult71 = (half4(appendResult69 , ( appendResult73 * _TimeParameters.x )));
				#if defined(_DISTORTTEXSTPATTERN_ONLYST)
				half4 staticSwitch74 = _DistortTexST;
				#elif defined(_DISTORTTEXSTPATTERN_FLOWBYTIME)
				half4 staticSwitch74 = appendResult71;
				#else
				half4 staticSwitch74 = _DistortTexST;
				#endif
				half4 break66 = staticSwitch74;
				half2 appendResult68 = (half2(break66.x , break66.y));
				half2 appendResult67 = (half2(break66.z , break66.w));
				half2 texCoord65 = IN.ase_texcoord3.xy * appendResult68 + appendResult67;
				half4 tex2DNode64 = tex2D( _DistortTexture, texCoord65 );
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
				half4 tex2DNode6 = tex2D( _MainTex, ( texCoord11 + DistortOutput84 ) );
				half4 temp_cast_0 = (tex2DNode6.r).xxxx;
				half4 temp_cast_1 = (tex2DNode6.g).xxxx;
				half4 temp_cast_2 = (tex2DNode6.b).xxxx;
				half4 temp_cast_3 = (tex2DNode6.a).xxxx;
				#if defined(_MAINTEXCHANNEL_RGB)
				half4 staticSwitch32 = tex2DNode6;
				#elif defined(_MAINTEXCHANNEL_R)
				half4 staticSwitch32 = temp_cast_0;
				#elif defined(_MAINTEXCHANNEL_G)
				half4 staticSwitch32 = temp_cast_1;
				#elif defined(_MAINTEXCHANNEL_B)
				half4 staticSwitch32 = temp_cast_2;
				#elif defined(_MAINTEXCHANNEL_A)
				half4 staticSwitch32 = temp_cast_3;
				#else
				half4 staticSwitch32 = tex2DNode6;
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
				half2 texCoord43 = IN.ase_texcoord3.xy * appendResult46 + appendResult45;
				half4 tex2DNode36 = tex2D( _MaskTexture, texCoord43 );
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
				float4 screenPos = IN.ase_texcoord5;
				half4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth57 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				half distanceDepth57 = abs( ( screenDepth57 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DepthFade ) );
				#ifdef _USEDEPTHFADE_ON
				half staticSwitch59 = saturate( distanceDepth57 );
				#else
				half staticSwitch59 = 1.0;
				#endif
				
				#if defined(_ALPHACHANNEL_R)
				half staticSwitch33 = tex2DNode6.r;
				#elif defined(_ALPHACHANNEL_G)
				half staticSwitch33 = tex2DNode6.g;
				#elif defined(_ALPHACHANNEL_B)
				half staticSwitch33 = tex2DNode6.b;
				#elif defined(_ALPHACHANNEL_A)
				half staticSwitch33 = tex2DNode6.a;
				#else
				half staticSwitch33 = tex2DNode6.a;
				#endif
				#ifdef _MASKAFFECTALPHA_ON
				half staticSwitch53 = temp_output_77_0;
				#else
				half staticSwitch53 = 1.0;
				#endif
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( _MainColor * staticSwitch32 * IN.ase_color * temp_output_77_0 * staticSwitch59 ).rgb;
				float Alpha = saturate( ( staticSwitch33 * IN.ase_color.a * staticSwitch53 * _FinalAlphaDeepen ) );
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

			
			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#pragma shader_feature_local _ALPHACHANNEL_R _ALPHACHANNEL_G _ALPHACHANNEL_B _ALPHACHANNEL_A
			#pragma shader_feature_local _MAINTEXSTPATTERN_ONLYST _MAINTEXSTPATTERN_FLOWBYTIME _MAINTEXSTPATTERN_CUSTOMDATAXY
			#pragma shader_feature_local _DISTORTCHANNEL_R _DISTORTCHANNEL_G _DISTORTCHANNEL_B _DISTORTCHANNEL_A
			#pragma shader_feature_local _DISTORTTEXSTPATTERN_ONLYST _DISTORTTEXSTPATTERN_FLOWBYTIME
			#pragma shader_feature_local _MASKAFFECTALPHA_ON
			#pragma shader_feature_local _MASKCHANNEL_R _MASKCHANNEL_G _MASKCHANNEL_B _MASKCHANNEL_A
			#pragma shader_feature_local _MASKTEXSTPATTERN_ONLYST _MASKTEXSTPATTERN_FLOWBYTIME _MASKTEXSTPATTERN_CUSTOMDATAXY


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				half4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
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
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _MainColor;
			half4 _MainTexST;
			half4 _DistortTexST;
			half4 _MaskTexST;
			half _CullMode;
			half _ZWrite;
			half _DistortStrength;
			half _MaskPower;
			half _MaskMultiply;
			half _DepthFade;
			half _FinalAlphaDeepen;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			sampler2D _DistortTexture;
			sampler2D _MaskTexture;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord2 = v.ase_texcoord;
				o.ase_color = v.ase_color;
				o.ase_texcoord3 = v.ase_texcoord1;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
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
				half4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;

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
				o.ase_color = v.ase_color;
				o.ase_texcoord1 = v.ase_texcoord1;
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
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
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
				#if defined(_DISTORTTEXSTPATTERN_ONLYST)
				half4 staticSwitch74 = _DistortTexST;
				#elif defined(_DISTORTTEXSTPATTERN_FLOWBYTIME)
				half4 staticSwitch74 = appendResult71;
				#else
				half4 staticSwitch74 = _DistortTexST;
				#endif
				half4 break66 = staticSwitch74;
				half2 appendResult68 = (half2(break66.x , break66.y));
				half2 appendResult67 = (half2(break66.z , break66.w));
				half2 texCoord65 = IN.ase_texcoord2.xy * appendResult68 + appendResult67;
				half4 tex2DNode64 = tex2D( _DistortTexture, texCoord65 );
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
				half4 tex2DNode6 = tex2D( _MainTex, ( texCoord11 + DistortOutput84 ) );
				#if defined(_ALPHACHANNEL_R)
				half staticSwitch33 = tex2DNode6.r;
				#elif defined(_ALPHACHANNEL_G)
				half staticSwitch33 = tex2DNode6.g;
				#elif defined(_ALPHACHANNEL_B)
				half staticSwitch33 = tex2DNode6.b;
				#elif defined(_ALPHACHANNEL_A)
				half staticSwitch33 = tex2DNode6.a;
				#else
				half staticSwitch33 = tex2DNode6.a;
				#endif
				half2 appendResult37 = (half2(_MaskTexST.x , _MaskTexST.y));
				half2 appendResult41 = (half2(_MaskTexST.z , _MaskTexST.w));
				half4 appendResult39 = (half4(appendResult37 , ( appendResult41 * _TimeParameters.x )));
				half4 texCoord48 = IN.ase_texcoord3;
				texCoord48.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
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
				half4 tex2DNode36 = tex2D( _MaskTexture, texCoord43 );
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
				#ifdef _MASKAFFECTALPHA_ON
				half staticSwitch53 = temp_output_77_0;
				#else
				half staticSwitch53 = 1.0;
				#endif
				
				float Alpha = saturate( ( staticSwitch33 * IN.ase_color.a * staticSwitch53 * _FinalAlphaDeepen ) );
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
Node;AmplifyShaderEditor.CommentaryNode;88;-2738.91,2055.3;Inherit;False;2578.743;409.2839;Comment;16;65;66;67;68;69;70;71;72;73;74;75;64;81;80;83;84;Distort Setting;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;75;-2688.91,2119.797;Inherit;False;Property;_DistortTexST;DistortTex ST;13;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;72;-2491.643,2354.184;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;73;-2453.643,2262.183;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-2324.642,2262.183;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;69;-2453.643,2171.183;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;62;-2687.7,668.1826;Inherit;False;2426.075;673.5352;Comment;22;53;77;54;76;79;52;78;36;43;46;45;44;47;39;49;42;38;37;41;40;48;50;Mask Setting;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;71;-2185.642,2171.183;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;50;-2637.7,784.8586;Inherit;False;Property;_MaskTexST;MaskTex ST;6;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;34;-2683.485,-130.4292;Inherit;False;2326.861;671.8173;Comment;20;17;25;12;15;29;31;28;11;24;19;21;23;22;18;33;32;6;9;85;87;MainTex Setting;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-2489.812,1137.718;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;40;-2440.433,1019.245;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;41;-2402.433,927.2446;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;74;-1996.555,2121.837;Inherit;False;Property;_DistortTexSTPattern;DistortTex ST Pattern;14;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;OnlyST;FlowbyTime;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-2273.432,927.2446;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;17;-2588.847,-66.99994;Inherit;False;Property;_MainTexST;MainTex ST;1;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;42;-2270.432,1161.245;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;66;-1738.94,2127.61;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;37;-2402.433,836.2446;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;21;-2391.579,167.386;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;19;-2353.579,75.38596;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2444.859,237.7585;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;49;-2135.432,1137.245;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;67;-1607.94,2200.611;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;68;-1606.94,2106.61;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-2134.432,836.2446;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;24;-2221.579,309.386;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;65;-1477.719,2134.175;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-2224.579,75.38596;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-2353.579,-15.61404;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;47;-1945.345,786.8981;Inherit;False;Property;_MaskTexSTPattern;MaskTex ST Pattern;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;3;OnlyST;FlowbyTime;CustomDataXY;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;23;-2085.581,-15.61404;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-2086.581,285.386;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;64;-1202.832,2105.3;Inherit;True;Property;_DistortTexture;Distort Texture;12;1;[Header];Create;True;1;Distort;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;44;-1691.731,792.6719;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StaticSwitch;81;-892.4246,2128.574;Inherit;False;Property;_DistortChannel;Distort Channel;16;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;R;G;B;A;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;45;-1556.731,865.6719;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;15;-1896.494,-64.96052;Inherit;False;Property;_MainTexSTPattern;MainTex ST Pattern;3;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;3;OnlyST;FlowbyTime;CustomDataXY;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;46;-1555.731,771.6719;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-850.202,2313.438;Inherit;False;Property;_DistortStrength;Distort Strength;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-1426.51,799.2359;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;28;-1642.88,-59.18669;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-631.4225,2132.999;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1506.88,-80.18667;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-1507.88,13.81333;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;36;-1163.616,770.3696;Inherit;True;Property;_MaskTexture;Mask Texture;5;1;[Header];Create;True;1;Mask;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;84;-384.9669,2129.047;Inherit;False;DistortOutput;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1354.833,132.0702;Inherit;False;84;DistortOutput;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-796.3055,1023.708;Inherit;False;Property;_MaskPower;Mask Power;10;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1377.659,-52.62271;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;52;-841.7036,794.3155;Inherit;False;Property;_MaskChannel;Mask Channel;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;R;G;B;A;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;-1101.833,-52.92984;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;76;-611.2301,918.9399;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-794.8922,1102.86;Inherit;False;Property;_MaskMultiply;Mask Multiply;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-768.1708,718.1826;Inherit;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-458.5784,918.9397;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-943.5879,-80.42919;Inherit;True;Property;_MainTex;MainTex;0;1;[Header];Create;True;1;MainTex;0;0;False;0;False;-1;None;3c900273a67659c4fa6348655b97faa4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;33;-604.3469,139.9845;Inherit;False;Property;_AlphaChannel;Alpha Channel;18;0;Create;True;0;0;0;False;0;False;0;3;3;True;;KeywordEnum;4;R;G;B;A;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-507.3174,590.2906;Inherit;False;Property;_FinalAlphaDeepen;Final Alpha Deepen;19;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;9;-810.0839,357.1765;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;53;-528.8513,773.1423;Inherit;False;Property;_MaskAffectAlpha;Mask Affect Alpha ?;9;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-211.4954,427.4131;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;63;-1235.422,1429.48;Inherit;False;944.8007;245.5021;Comment;5;60;57;58;59;61;Depth Setting;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;32;-611.8246,-80.07245;Inherit;False;Property;_MainTexChannel;MainTex Channel;4;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;5;RGB;R;G;B;A;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-21.85189,-339.774;Inherit;False;Property;_CullMode;Cull Mode;17;2;[Header];[Enum];Create;True;1;Other Setting;1;Option1;0;1;UnityEngine.Rendering.CullMode;True;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-247.6557,-97.79272;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;7;-517.4949,-385.3324;Inherit;False;Property;_MainColor;MainColor;2;2;[HDR];[Header];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;60;-720.2469,1479.48;Inherit;False;Constant;_Float1;Float 1;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;61;-714.4205,1564.582;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;57;-987.4207,1502.582;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;55;50.83545,428.4338;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1185.422,1520.582;Inherit;False;Property;_DepthFade;DepthFade;21;0;Create;True;0;0;0;False;0;False;0;-12.76;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;59;-551.4204,1499.582;Inherit;False;Property;_UseDepthFade;Use Depth Fade;20;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;3;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2;316.2518,-96.04712;Half;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;To7/ParticleAdd;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;0;True;12;all;0;False;True;1;1;False;;1;False;;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;True;True;2;True;_ZWrite;True;3;True;_ZTest;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;False;0;Hidden/InternalErrorShader;0;0;Standard;22;Surface;1;637871831662488076;  Blend;2;637871859041593815;Two Sided;1;0;Cast Shadows;0;637871831758211704;  Use Shadow Threshold;0;0;Receive Shadows;0;637871831745536286;GPU Instancing;1;0;LOD CrossFade;0;0;Built-in Fog;0;0;DOTS Instancing;0;0;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position,InvertActionOnDeselection;1;0;0;5;False;True;False;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;4;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;5;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-85.03839,160.9647;Inherit;False;Property;_ZTest;ZTest;23;1;[Enum];Create;True;0;9;Always;0;Never;1;Less;2;Equal;3;LEqual;4;Greater;5;NotEqual;6;GEqual;7;Always;8;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-90.31396,238.1094;Inherit;False;Property;_ZWrite;ZWrite;22;1;[Enum];Create;True;0;2;On;0;Off;1;1;UnityEngine.Rendering.CullMode;True;0;False;1;2;0;0;0;1;FLOAT;0
WireConnection;73;0;75;3
WireConnection;73;1;75;4
WireConnection;70;0;73;0
WireConnection;70;1;72;0
WireConnection;69;0;75;1
WireConnection;69;1;75;2
WireConnection;71;0;69;0
WireConnection;71;2;70;0
WireConnection;41;0;50;3
WireConnection;41;1;50;4
WireConnection;74;1;75;0
WireConnection;74;0;71;0
WireConnection;38;0;41;0
WireConnection;38;1;40;0
WireConnection;42;0;48;1
WireConnection;42;1;48;2
WireConnection;66;0;74;0
WireConnection;37;0;50;1
WireConnection;37;1;50;2
WireConnection;19;0;17;3
WireConnection;19;1;17;4
WireConnection;49;0;37;0
WireConnection;49;2;42;0
WireConnection;67;0;66;2
WireConnection;67;1;66;3
WireConnection;68;0;66;0
WireConnection;68;1;66;1
WireConnection;39;0;37;0
WireConnection;39;2;38;0
WireConnection;24;0;12;3
WireConnection;24;1;12;4
WireConnection;65;0;68;0
WireConnection;65;1;67;0
WireConnection;22;0;19;0
WireConnection;22;1;21;0
WireConnection;18;0;17;1
WireConnection;18;1;17;2
WireConnection;47;1;50;0
WireConnection;47;0;39;0
WireConnection;47;2;49;0
WireConnection;23;0;18;0
WireConnection;23;2;22;0
WireConnection;25;0;18;0
WireConnection;25;2;24;0
WireConnection;64;1;65;0
WireConnection;44;0;47;0
WireConnection;81;1;64;1
WireConnection;81;0;64;2
WireConnection;81;2;64;3
WireConnection;81;3;64;4
WireConnection;45;0;44;2
WireConnection;45;1;44;3
WireConnection;15;1;17;0
WireConnection;15;0;23;0
WireConnection;15;2;25;0
WireConnection;46;0;44;0
WireConnection;46;1;44;1
WireConnection;43;0;46;0
WireConnection;43;1;45;0
WireConnection;28;0;15;0
WireConnection;80;0;81;0
WireConnection;80;1;83;0
WireConnection;29;0;28;0
WireConnection;29;1;28;1
WireConnection;31;0;28;2
WireConnection;31;1;28;3
WireConnection;36;1;43;0
WireConnection;84;0;80;0
WireConnection;11;0;29;0
WireConnection;11;1;31;0
WireConnection;52;1;36;1
WireConnection;52;0;36;2
WireConnection;52;2;36;3
WireConnection;52;3;36;4
WireConnection;85;0;11;0
WireConnection;85;1;87;0
WireConnection;76;0;52;0
WireConnection;76;1;78;0
WireConnection;77;0;76;0
WireConnection;77;1;79;0
WireConnection;6;1;85;0
WireConnection;33;1;6;1
WireConnection;33;0;6;2
WireConnection;33;2;6;3
WireConnection;33;3;6;4
WireConnection;53;1;54;0
WireConnection;53;0;77;0
WireConnection;10;0;33;0
WireConnection;10;1;9;4
WireConnection;10;2;53;0
WireConnection;10;3;89;0
WireConnection;32;1;6;0
WireConnection;32;0;6;1
WireConnection;32;2;6;2
WireConnection;32;3;6;3
WireConnection;32;4;6;4
WireConnection;8;0;7;0
WireConnection;8;1;32;0
WireConnection;8;2;9;0
WireConnection;8;3;77;0
WireConnection;8;4;59;0
WireConnection;61;0;57;0
WireConnection;57;0;58;0
WireConnection;55;0;10;0
WireConnection;59;1;60;0
WireConnection;59;0;61;0
WireConnection;2;2;8;0
WireConnection;2;3;55;0
ASEEND*/
//CHKSM=F9C70B5CC8569C80ACFC2E3D9AAAEFD570BA9274