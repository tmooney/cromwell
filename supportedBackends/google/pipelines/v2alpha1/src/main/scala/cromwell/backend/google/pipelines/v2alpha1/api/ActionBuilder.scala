package cromwell.backend.google.pipelines.v2alpha1.api

import akka.http.scaladsl.model.ContentTypes
import com.google.api.services.genomics.v2alpha1.model.{Action, Mount}
import cromwell.backend.google.pipelines.v2alpha1.api.ActionBuilder.Gsutil.ContentTypeTextHeader
import cromwell.backend.google.pipelines.v2alpha1.api.ActionFlag.ActionFlag
import mouse.all._

import scala.collection.JavaConverters._

/**
  * Utility singleton to create high level actions.
  */
object ActionBuilder {
  object Gsutil {
    private val contentTypeText = ContentTypes.`text/plain(UTF-8)`.toString()
    val ContentTypeTextHeader = s"Content-Type: $contentTypeText"
  }
  
  private val cloudSdkImage = "google/cloud-sdk:alpine"
  private def cloudSdkAction: Action = new Action().setImageUri(cloudSdkImage)

  private def javaFlags(flags: List[ActionFlag]) = flags.map(_.toString).asJava

  def userAction(docker: String, command: String, mounts: List[Mount], labels: Map[String, String]): Action = {
    new Action()
      .setImageUri(docker)
      .setCommands(List("/bin/bash", "-c", command).asJava)
      .setMounts(mounts.asJava)
      .setLabels(labels.asJava)
  }
  
  def gsutilAsText(command: String*)(mounts: List[Mount] = List.empty, flags: List[ActionFlag] = List.empty): Action = {
    gsutil(List("-h", ContentTypeTextHeader) ++ command.toList: _*)(mounts, flags)
  }

  def gsutil(command: String*)(mounts: List[Mount] = List.empty, flags: List[ActionFlag] = List.empty): Action = {
    cloudSdkAction
      .setCommands((List("gsutil") ++ command.toList).asJava)
      .setFlags(flags |> javaFlags)
      .setMounts(mounts.asJava)
  }
}
